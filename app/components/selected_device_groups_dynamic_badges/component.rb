# frozen_string_literal: true

class SelectedDeviceGroupsDynamicBadges::Component < ApplicationViewComponent
    renders_one :hidden_input
    option :groups, default: proc { [] }
    option :badge_data, default: proc { Hash.new }
    option :selected_groups, default: proc { { n_group_selector_target:"selectedGroups", accessible_groups_target:"selectedGroups"} }
    option :remaining_count, default: proc { { n_group_selector_target: "remainingCount", accessible_groups_target:"remainingCount"} }
    option :none_selected, default: proc { {n_group_selector_target: "noneSelected", accessible_groups_target:"noneSelected"} }
    option :template_target, default: proc { "accessible-groups" }
    option :badge_count,default: proc { 3 }
    option :text, default: proc { I18n.t("common.none_selected") }
    
    def badge_data_attr
        @badge_data.merge({ id: "NEW_ID", name: "GROUP_NAME", type_id: "TYPE_ID_ATTR", name_attr: "NAME_ATTR",selected_parent_selector: "GROUP_TYPE", hierarchical_name: "HIERACHICAL_NAME",device_count: "DEVICE_COUNT", parent_id: "PARENT_ID"})
    end 
end
  