class DeviceNGroupSelector::Component < ApplicationViewComponent
    include ApplicationHelper
    include V3::DeviceGroupsHelper
    renders_one :actions

    renders_one :warning
    option :partial_path, default: proc { nil }
    option :single_select_group, default: proc { false }
    option :action, default: proc { nil }
    option :parent_name, default: proc { nil }
    option :parent_groups, default: proc { nil }
    option :group_device_counts, default: proc { nil }
    option :group_user_counts, default: proc { nil }
    option :organization_unit_counts, default: proc { nil }
    option :type, default: proc { "checkbox" }
    option :show_badge_chip, default: proc { false }
    option :show_count, default: proc { true }
    option :show_selected_group, default: proc { false }
    option :selected_group, default: proc { [] }
    option :toggle_all, default: proc { true }
    option :group, default: proc {"device-group"} 
    option :name, default: proc { nil }
    option :text, default: proc { nil }
    option :disabled_selected, default: proc { false }
    option :user_groups, default: proc { nil }
    option :device_groups, default: proc { nil }
    option :organization_units, default: proc { nil }
    option :include_device_groups_ids, default: proc { nil }
    option :include_user_groups_ids, default: proc { nil }
    option :include_organization_units_ids, default: proc { nil }
    option :parent_group, default: proc { nil }
    option :disabled_selected_group, default: proc { [] }
    option :checkbox_actions, default: proc { nil }
    option :is_unpublish_group, default: proc { false }
    option :is_group, default: proc { true }
    option :published_device_groups_ids, default: proc { [] }
    option :published_user_groups_ids, default: proc { [] }
    option :show_selected_count, default: proc { false }
    option :is_propublish_group, default: proc { false }
    option :is_workflow_running, default: proc { false }
    option :workflow_name, default: proc { nil }
    option :data, default: proc { Hash.new }
    option :is_move_device_to_group, default: proc { false }
    option :label, default: proc { I18n.t("common.group_name") }
    option :height, default: proc { "350px" }
    option :show_publish_version, default: proc { false }
    option :enable_group_based_publish, default: proc { false }
    option :show_installation_mode_group, default: proc { false }
    option :app_type, default: proc { "" }
    option :existing_groups_info, default: proc { nil }
    option :existing_user_groups_info, default: proc { nil }
    option :show_configuration_for_group, default: proc { false }
    option :show_configuration_for_group_for_pfw, default: proc { false }
    option :pfw_configuration_for_group, default: proc { Hash.new }
    option :show_profile_version, default: proc { false }   
    option :existing_profile_info, default: proc { nil }
    option :configuration_name_for_group_hash, default: proc { Hash.new }
end