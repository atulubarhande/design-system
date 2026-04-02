class MultiSelectGroup::Component < ApplicationViewComponent
    include ApplicationHelper
    include V3::DeviceGroupsHelper
    option :checkbox_group, default: proc { nil }
    option :parent_group, default: proc { nil }
    option :parent_name, default: proc { nil }
    option :action, default: proc { nil }
    option :group_device_counts, default: proc { nil }
    option :group_user_counts, default: proc { nil }
    option :organization_unit_counts, default: proc { nil }
    option :name, default: proc { nil }
    option :type, default: proc { "checkbox" }
    option :group, default: proc { nil }
    option :show_badge_chip, default: proc { false }
    option :show_count, default: proc { true }
    option :show_selected_group, default: proc { false }
    option :selected_group, default: proc { nil }
    option :disabled_selected, default: proc { false }
    option :include_device_groups_ids, default: proc { nil }
    option :include_user_groups_ids, default: proc { nil }
    option :include_organization_units_ids, default: proc { nil }
    option :local_assign, default: proc { nil }
    option :checkbox_actions, default: proc { nil }
    option :data, default: proc { Hash.new }
    option :is_unpublish_group, default: proc { false }
    option :is_group, default: proc { true }
    option :published_device_groups_ids, default: proc { [] }
    option :published_user_groups_ids, default: proc { [] }
    option :is_workflow_running, default: proc { false }
    option :workflow_name, default: proc { nil }
    option :show_publish_version, default: proc { false }
    option :enable_group_based_publish, default: proc { false }
    option :show_installation_mode, default: proc { false }
    option :app_type, default: proc { "" }
    option :existing_groups_info, default: proc { nil }
    option :existing_user_groups_info, default: proc { nil }
    option :show_configuration_for_group, default: proc { false }
    option :show_installation_mode_group, default: proc { false }
    option :show_configuration_for_group_for_pfw, default: proc { false }
    option :pfw_configuration_for_group, default: proc { Hash.new }
    option :show_profile_version, default: proc { false }
    option :existing_profile_info, default: proc { nil }
    option :configuration_name_for_group_hash, default: proc { Hash.new }
    
    def group_n_sub_group_names(checkbox_group)
        return  all_subgroup_names(checkbox_group, include_groups_ids(checkbox_group)) + (checkbox_group.parent_group.present? ? all_parent_group_names(checkbox_group) : "")
    end

    def current_selected(checkbox_group)
        return (@selected_group&.include? "#{checkbox_group&.class&.to_s}-#{checkbox_group&.id}") || (@selected_group&.map(&:to_i)&.include? checkbox_group&.id)
    end

    #deprecated        
    def disabled_selected_groups(checkbox_group)
        if(@disabled_selected)
            return (@selected_group&.include? "#{@parent_group&.class&.to_s}-#{@parent_group&.id}") || (@selected_group&.include? "#{checkbox_group&.id}")
        end
    end

    def group_type(group)
        if group.is_a?(OrganizationUserGroup)
            OrganizationUserGroup
        elsif group.is_a?(OrganizationUnit)
            return OrganizationUnit
        else
            DeviceGroup
        end
    end

    def include_groups_ids(group)
        if group.is_a?(OrganizationUserGroup)
            @include_user_groups_ids
        elsif group.is_a?(OrganizationUnit)
            return @include_organization_units_ids
        else
            @include_device_groups_ids
        end
    end
    

    # Check if the parent group has only one subgroup and that subgroup is published then hide summary icon
    def has_last_visible_groups(checkbox_group)
        if checkbox_group.is_a?(OrganizationUserGroup)
            return checkbox_group.child_group_ids.all? { |i| @published_user_groups_ids.include?(i) }
        else
            return checkbox_group.child_group_ids.all? { |i| @published_device_groups_ids.include?(i) }
        end
    end

    def workflow_title(workflow_name)
        @is_workflow_running ?  I18n.t('v2.work_flows.errors.unpublish_presentation_error', workflow_names: @workflow_name) : ""
    end

    def installation_mode_display
        return 'silent_install' unless @checkbox_group&.apple_device_profile&.enable_app_catalog
        
        @checkbox_group.apple_device_profile.apple_app_catalog_setting&.app_install_mode || 'silent_install'
    end

    def android_device_profile_name(checkbox_group)
        default_name = "N/A"
      
        if checkbox_group.is_a?(OrganizationUserGroup)
          android_name = checkbox_group.android_device_profile&.name.presence || default_name
          co_android_name = checkbox_group.co_android_device_profile&.name.presence || default_name
      
          return "#{android_name} | #{co_android_name}" if checkbox_group.co_android_device_profile.present?
          return android_name
        end
      
        checkbox_group.device_profile&.name.presence || default_name
    end
      
end
