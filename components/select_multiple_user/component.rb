# frozen_string_literal: true

class SelectMultipleUser::Component < ApplicationViewComponent
  include ApplicationHelper

  option :users
  option :billing_contacts
  option :name
  option :disabled_user_ids, default: proc { [] }
  option :hide_select_all_checkbox, default: proc { false }
  option :disable_all_options, default: proc { false }
  option :label, default: proc { nil }

  def selected_users_ids
    billing_contacts&.pluck(:user_id) || []
  end

  def selected_users_names
    return t('common.select_user_from_list') if billing_contacts.blank?
    if billing_contacts.length == 1
      "#{billing_contacts.first.name} (#{billing_contacts.first.email})"
    elsif billing_contacts.length == 2
      "#{billing_contacts.first(2).pluck(:name).join(', ')}"
    else
      "#{billing_contacts.first(2).pluck(:name).join(', ')} &  #{(billing_contacts.length - 2).to_s} other"
    end
  end

end
