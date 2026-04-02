class SingleSelectGroup::Component < ApplicationViewComponent
    include ApplicationHelper
    include V3::DeviceGroupsHelper

    option :radio_group, default: proc { nil }
    option :parent_group, default: proc { nil }
    option :parent_name, default: proc { nil }
    option :checkbox_actions, default: proc { nil }
    option :group_device_counts, default: proc { nil }
    option :group_user_counts, default: proc { nil }
    option :organization_unit_counts, default: proc { nil }
    option :name, default: proc { nil }
    option :type, default: proc { "checkbox" }
    option :show_badge_chip, default: proc { false }
    option :group, default: proc { nil }
    option :include_device_groups_ids, default: proc { nil }
    option :include_user_groups_ids, default: proc { nil }
    option :include_organization_units_ids, default: proc { nil }
    option :disabled_selected_group, default: proc { [] }
    option :data, default: proc { Hash.new }


    def group_n_sub_group_names(radio_group)
        return all_subgroup_names(radio_group, include_groups_ids(radio_group)) + (radio_group.parent_group.present? ? all_parent_group_names(radio_group) : "")
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

    def disabled_selected_groups(id)
        if !@disabled_selected_group.nil?
            return (@disabled_selected_group.include?(id.to_s)) ? true : false
        end
    end
end