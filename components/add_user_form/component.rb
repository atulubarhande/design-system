class AddUserForm::Component < ApplicationViewComponent
  # TO DO: Need to remove Application Helper from this file and include in Application View Component
  include ApplicationHelper
  include Turbo::FramesHelper

  # OneIdP domain constant
  ONE_IDP_DOMAIN = ENV['ONE_IDP_DOMAIN'].freeze

  option :current_user, default: proc { nil }
  option :domains, default: proc { [] }
  option :domain, default: proc { nil }
  option :co_profile_user_groups, default: proc { [] }
  option :custom_fields, default: proc { [] }
  option :custom_values, default: proc { [] }
  option :user, default: proc { nil }
  option :user_group_url, default: proc { "" }
  option :selected_domain, default: proc { Hash.new }
  option :selected_auth_source, default: proc { nil }

  def domain_info
    if domain.present?
      {
        context: :single_domain,
        selected_domain: domain[:domain] || domain,
        auth_source_options: domain[:auth_source_options] || default_auth_source_options,
        has_context: true
      }
    elsif domains.present? && domains.any?
      verified_enabled_domains = domains.select { |d| d[:verified] && d[:enabled] }
      oneidp_domain = verified_enabled_domains.find { |d| d[:name].include?(ONE_IDP_DOMAIN) }
      selected_domain = oneidp_domain || nil

      {
        context: :multiple_domains,
        domains: verified_enabled_domains,
        selected_domain: selected_domain,
        auth_source_options: selected_domain&.dig(:auth_source_options) || default_auth_source_options,
        has_context: true,
        oneidp_domain_exists: oneidp_domain.present?
      }
    else
      {
        context: :no_domains,
        domains: [],
        selected_domain: nil,
        auth_source_options: default_auth_source_options,
        has_context: false
      }
    end
  end

  def add_to_oneidp_checkbox_checked?
    return true if user&.added_to_oneidp

    domain_data = domain_info
    return false unless domain_data[:has_context]

    if domain_data[:context] == :single_domain && user.blank?
      return true
    end

    # For edit forms, allow checkbox to be checked (user can change OneIdP status)
    # For new forms, check if selected domain is OneIdP domain
    if user.present?
      return false  # Start unchecked for edit forms
    else
      selected_domain_name = domain_data[:selected_domain]&.dig(:name)
      return selected_domain_name&.include?(ONE_IDP_DOMAIN) || false
    end
  end

  def add_to_oneidp_checkbox_disabled?
    return true if user&.added_to_oneidp

    domain_data = domain_info
    return true unless domain_data[:has_context]

    if domain_data[:context] == :single_domain && user.blank?
      return true
    end

    # For edit forms, allow checkbox to be enabled (user can change OneIdP status)
    # For new forms, disable based on domain type
    if user.present?
      return false # Allow editing for existing users
    else
      selected_domain_name = domain_data[:selected_domain]&.dig(:name)
      return true if selected_domain_name&.include?(ONE_IDP_DOMAIN)
      return true if other_option_selected?
      return false
    end
  end

  def auth_source_disabled?
    return false if user&.added_to_oneidp

    domain_data = domain_info
    return true unless domain_data[:has_context]

    return true if other_option_selected?

    # Auth source is disabled when checkbox is unchecked, enabled when checked
    !add_to_oneidp_checkbox_checked?
  end

  def password_disabled?
    return true if user&.added_to_oneidp

    domain_data = domain_info
    return true unless domain_data[:has_context]

    return true if other_option_selected?

    !add_to_oneidp_checkbox_checked?
  end

  def send_email_checkbox_disabled?
    # If user is added to OneIdP, checkbox is disabled
    return true if user&.added_to_oneidp

    # If editing a user, checkbox is disabled
    return true if user.present?

    # For new forms only: check if email service is enabled for the selected domain
    domain_data = domain_info
    return true unless domain_data[:has_context]

    selected_domain = domain_data[:selected_domain]
    return true unless selected_domain

    # Checkbox is disabled if email service is disabled for the domain
    !selected_domain[:email_service_enabled]
  end

  def send_email_checkbox_checked?
    # If user is added to OneIdP, checkbox is unchecked
    return false if user&.added_to_oneidp

    # If editing a user who is not added to OneIdP, checkbox is unchecked
    return false if user.present?

    # For new forms only: check if email service is enabled for the selected domain
    domain_data = domain_info
    return false unless domain_data[:has_context]

    selected_domain = domain_data[:selected_domain]
    return false unless selected_domain

    # Checkbox is checked if email service is enabled for the selected domain
    selected_domain[:email_service_enabled]
  end

  def other_option_selected?
    domain_data = domain_info
    return false unless domain_data[:has_context]

    # For edit forms, check if user's email domain exists in available domains
    if user.present?
      # Check if user's email domain exists in available domains
      if user.email&.include?('@')
        email_domain = user.email.split('@').last
        available_domain = find_domain_by_name(email_domain)

        # If domain exists in available domains, "Other" is NOT selected
        # If domain NOT found, "Other" IS selected
        return !available_domain.present?
      else
        # User has no @ in email, treat as "Other"
        return true
      end
    end

    # For new forms, check if "Other" domain is selected
    if domain_data[:context] == :multiple_domains
      # If selected_domain is nil, it means "Other" should be selected
      return domain_data[:selected_domain].nil?
    elsif domain_data[:context] == :no_domains
      # When there are no domains, "Other" is always selected
      return true
    end

    false
  end

  def domain_attribute(attribute, key=nil)
    domain_data = domain_info
    return nil unless domain_data[:has_context]

    selected_domain = domain_data[:selected_domain]
    return nil unless selected_domain

    if attribute == "password_policy"
      selected_domain.dig(attribute.to_sym, key.to_sym)
    else
      selected_domain[attribute.to_sym]
    end
  end

  def password_policy_min_length
    apply_to_admins = domain_attribute("password_policy", "apply_to_admins")
    if apply_to_admins
      min_length = domain_attribute("password_policy", "min_length")
      min_length || 8
    else
      8
    end
  end

  def user_custom_field(custom_values, field_id)
    field = custom_values.select { |value| value[:org_user_custom_field_id] == field_id }
    field.first if field.present?
  end

  def show_domain_section?
    read_only_access('OneIdpDirectory') && !read_only_access('OneIdpDirectory-ReadOnly')
  end

  def auth_source_options
    # For edit forms, if user has a domain, use that domain's auth source options
    if user.present?
      if user.added_to_oneidp && user.one_idp_domain.present?
        # User is added to OneIdP and has a domain
        user_domain = find_user_domain
        if user_domain
          options = user_domain[:auth_source_options] || default_auth_source_options
          return map_auth_source_options(options)
        end
      else
        # User is not added to OneIdP - check if their email domain exists in available domains
        email_domain = user.email&.split('@')&.last
        if email_domain.present?
          available_domain = find_domain_by_name(email_domain)
          if available_domain
            # Domain exists in available domains - use its auth source options
            options = available_domain[:auth_source_options] || default_auth_source_options
            return map_auth_source_options(options)
          end
        end
        # Domain not found in available domains - show "Other" options
        return default_auth_source_options
      end
    end

    # For new forms or when user domain not found, use general domain info
    options = domain_info[:auth_source_options] || default_auth_source_options
    if options.empty?
      default_auth_source_options
    else
      map_auth_source_options(options)
    end
  end

  def selected_domain
    if domain.present?
      domain[:domain] || domain
    elsif domains.present? && domains.any?
      verified_enabled_domains = domains.select { |d| d[:verified] && d[:enabled] }
      oneidp_domain = verified_enabled_domains.find { |d| d[:name].include?(ONE_IDP_DOMAIN) }
      oneidp_domain || verified_enabled_domains.first
    else
      nil
    end
  end

  def user_selected_auth_source
    selected_auth_source.present? ? selected_auth_source.to_s : "oneidp"
  end

  private

  def find_user_domain
    return nil unless user&.one_idp_domain.present?

    if domain.present?
      domain[:domain] || domain
    elsif domains.present? && domains.any?
      domains.find { |d| d[:verified] && d[:enabled] && d[:name] == user.one_idp_domain.name }
    else
      nil
    end
  end

  def map_auth_source_options(options)
    options.map do |option|
      {
        name: option[:name] || option['name'],
        value: (option[:value] || option['value']).to_s,
        idp_slug: option[:idp_slug] || option['idp_slug']
      }
    end
  end

  def password_required?
    !password_disabled?
  end

  def domain_select_disabled?
    user.present? || domain_info[:context] == :single_domain
  end

  def domain_select_css_class
    domain_select_disabled? ? 'bs-ui-disabled' : ''
  end

  def domain_name
    if user.present?
      if user.added_to_oneidp && user.one_idp_domain.present?
        user.one_idp_domain.name  # Show actual domain name
      else
        user_domain_name
      end
    else
      selected_domain.present? ? selected_domain[:name] : "Other"
    end
  end

  def domain_id
    if user.present?
      if user.added_to_oneidp && user.one_idp_domain.present?
        user.one_idp_domain.id    # Show actual domain ID
      else
        edit_form_domain_id  # Use new method for consistency
      end
    else
      selected_domain.present? ? selected_domain[:id] : nil
    end
  end

  # Edit form email value based on user's OneIdP status
  def user_email_value
    return nil unless user.present?

    if user.added_to_oneidp
      # OneIdP user: show email part only
      extract_email_part(user.email)
    else
      # Non-OneIdP user: check if domain exists in available domains
      if user_email_domain_exists_in_available_domains?
        extract_email_part(user.email)
      else
        # Domain not found: show full email
        user.email
      end
    end
  end

  # Edit form domain name based on user's OneIdP status
  def user_domain_name
    return nil unless user.present?

    if user.added_to_oneidp
      # OneIdP user: show domain part
      extract_domain_part(user.email)
    else
      # Non-OneIdP user: check if domain exists in available domains
      if user_email_domain_exists_in_available_domains?
        extract_domain_part(user.email)
      else
        # Domain not found: show "Other"
        "Other"
      end
    end
  end

  # Edit form domain ID based on user's OneIdP status
  def edit_form_domain_id
    return nil unless user.present?

    if user.added_to_oneidp
      # OneIdP user: show domain ID
      user.one_idp_domain&.id
    else
      # Non-OneIdP user: check if domain exists in available domains
      if user_email_domain_exists_in_available_domains?
        find_domain_by_name(extract_domain_part(user.email))&.dig(:id)
      else
        # Domain not found: no domain ID
        nil
      end
    end
  end

  def get_domain_data
    return nil unless domain.present?
    domain[:domain] || domain
  end

  # Get the domain value for JavaScript controller
  def user_domain_value
    if user.present?
      if user.added_to_oneidp && user.one_idp_domain.present?
        user.one_idp_domain.name
      elsif user.email&.include?('@')
        user_email_domain = extract_domain_part(user.email)
        available_domain = find_domain_by_name(user_email_domain)
        available_domain ? available_domain[:name] : "Other"
      else
        "Other"
      end
    else
      # For new forms, check if selected_domain is nil (which means "Other")
      domain_data = domain_info
      if domain_data[:context] == :multiple_domains && domain_data[:selected_domain].nil?
        "Other"
      else
        domain_data[:selected_domain]&.dig(:name) || "Other"
      end
    end
  end

  # Helper method to find domain by name from available domains
  def find_domain_by_name(domain_name)
    return nil unless domain_name.present?

    if domain.present?
      domain[:domain] || domain
    elsif domains.present? && domains.any?
      domains.find { |d| d[:verified] && d[:enabled] && d[:name] == domain_name }
    else
      nil
    end
  end

  # Check if user's email domain exists in available domains
  def user_email_domain_exists_in_available_domains?
    return false unless user&.email&.include?('@')

    email_domain = extract_domain_part(user.email)
    available_domain = find_domain_by_name(email_domain)

    available_domain.present?
  end

  # Extract email part (before @) from email address
  def extract_email_part(email)
    return email unless email&.include?('@')
    email.split('@').first
  end

  # Extract domain part (after @) from email address
  def extract_domain_part(email)
    return nil unless email&.include?('@')
    email.split('@').last
  end

  def default_auth_source_options
    [{name: "OneIdP", value: "oneidp", idp_slug: "oneidp"}]
  end

  # Password-supported authentication sources for JavaScript
  def password_supported_auth_sources
    OrganizationUser::PASSWORD_SUPPORTED_AUTH_SOURCES
  end

  # OneIdP domain for JavaScript
  def one_idp_domain_value
    ONE_IDP_DOMAIN
  end

  # Get domain object for edit forms
  def edit_form_domain_object
    return nil unless user.present?

    if user_domain_name == "Other"
      { name: "Other", id: nil }
    else
      find_domain_by_name(user_domain_name)
    end
  end
end
