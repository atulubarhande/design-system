# frozen_string_literal: true

class Store::AppPublish::Component < ApplicationViewComponent
  include ApplicationHelper
  renders_one :content_body
  renders_one :groups_form
  renders_one :profiles_form
  renders_one :devices_form
  renders_one :devices_search_form
  renders_one :group_search_form
  option :method, default: proc { nil }
  option :device_groups, default: proc { nil }
  option :user_groups, default: proc { nil }
  option :groups_allowed, default: proc { nil }
  option :profiles, default: proc { [] }
  option :profiles_allowed, default: proc { [] }
  option :devices, default: proc { nil }
  option :devices_allowed, default: proc { nil }
  option :selected_group_ids, default: proc { nil }
  option :selected_profile_ids, default: proc { [] }
  option :form_url, default: proc { Array.new }
  option :devices_list_url, default: proc { Array.new }
  option :device_group_name, default: proc { "device_group_ids[]" }
  option :user_group_name, default: proc { "user_group_ids[]" }
  option :app, default: proc { nil }
  option :group_device_counts, default: proc { 0 }
  option :group_user_counts, default: proc { 0 }
  option :bulk_threshold, default: proc { false }
  option :show_publish_version, default: proc { false }
  option :show_selected_count, default: proc { false }
  option :has_user_groups, default: proc { true }
  option :profile_partial_path, default: proc { "v3/device_profiles/device_profile_app_mgmt" }
  option :device_list_frame_id, default: proc { "accessible_devices_list" }
  option :device_list_partial_path, default: proc { "/store/store_apps/search_accessible_devices" }
  option :show_associated_group, default: proc { true }
  option :show_installation_mode, default: proc { false }
  option :show_selected_array, default: proc { true }
  option :disabled_profile_ids, default: proc { [] }
  option :title, default: proc { nil }
  option :disabled_selected_profile, default: proc { true }
  option :disabled_selected_group, default: proc { true }
  option :show_selected_group, default: proc { false }
  option :enable_group_based_publish, default: proc { true }
  option :show_badge_chip, default: proc { true }
  option :app_type, default: proc { "" }
  option :is_unpublish_group, default: proc { false }
  option :existing_groups_info, default: proc { nil }
  option :existing_user_groups_info, default: proc { nil }
  option :published_agent_info, default: proc { nil }
  option :published_agent_info_show, default: proc { false }
  option :show_device_count_label, default: proc { true }
  option :show_device_group_label, default: proc { true }
  option :show_configuration_for_group, default: proc { false }
  option :show_configuration_for_group_for_pfw, default: proc { false }
  option :pfw_configuration_for_group, default: proc { Hash.new }
  option :publish_agent_info_text, default: proc { I18n.t('enterpriseStore.agnet_version') }
  option :checkbox_actions, default: proc { "n-group-selector#updateSelectAllState n-group-selector#checkAllSubGroups" }
  option :group_header_text, default: proc { I18n.t("common.group_name") }
  option :show_installation_mode_group, default: proc{ false }
  option :label_name, default: proc{ "" }
  option :script_agent_show, default: proc { false }
  option :compatible_device_rc, default: proc { false }
  option :show_profile_version, default: proc { false }
  option :existing_profile_info, default: proc { nil }
  option :show_version_label, default: proc{ true }
  option :configuration_name_for_group_hash, default: proc { Hash.new }
  
  def allowed_tabs
    tabs = []
    tabs << I18n.t('common.groups') if @groups_allowed
    tabs << I18n.t('common.device_profiles') if @profiles_allowed
    tabs << I18n.t('common.devices') if @devices_allowed
    tabs
  end
    

  def disabled
    @profiles&.empty?
  end
end
