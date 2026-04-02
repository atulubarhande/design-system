class CheckboxGroupInput::Component < ApplicationViewComponent
    include ApplicationHelper
    include V3::DeviceGroupsHelper
    option :checkbox_group, default: proc { nil }
    option :selected_groups, default: proc { nil }
    option :parent_group, default: proc { nil }
    option :parent_name, default: proc { nil }
    option :action, default: proc { nil }
    option :group_device_counts, default: proc { false }
    option :name, default: proc { nil }
    option :workflow_name, default: proc { nil }
    option :disabled_group, default: proc { false }
    option :accessible_device_group_ids, default: proc { nil }
    option :is_unpublish_presentation, default: proc { false }
    option :published_presentation_ids, default: proc { nil }
    option :is_publish_presentation, default: proc { false }

    def parent_groups
        return Array(@device_groups).concat(Array(@user_groups).concat(@organization_units)).select {|group| parent_not_accessible_or_main_node.(group)}
    end

    def parent_selected
       return (@selected_groups&.include? "#{@parent_group&.class&.to_s}-#{@parent_group&.id}")
    end

    def current_selected
        return (@selected_groups&.include? "#{@checkbox_group&.class&.to_s}-#{@checkbox_group&.id}") 
    end

    def group_n_sub_group_names
        return @parent_name.nil? ? all_subgroup_names(@checkbox_group, @accessible_device_group_ids) : parent_name
    end

    # Check if the parent group has only one subgroup and that subgroup is published then hide summary icon
    def has_last_visible_group(checkbox_group)
        return checkbox_group.child_group_ids.all? { |i| @published_presentation_ids.include?(i) }
    end

    def workflow_title(workflow_name)
        disabled_group ?  I18n.t('v2.work_flows.errors.unpublish_presentation_error', workflow_names: workflow_name) : ""
    end
  
end