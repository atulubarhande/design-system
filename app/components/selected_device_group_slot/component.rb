# frozen_string_literal: true

class SelectedDeviceGroupSlot::Component < ApplicationViewComponent
    include ApplicationHelper
    renders_one :count
    option :group, default: proc { [] }
    option :group_id, default: proc { nil }
    option :name, default: proc { [] }
    option :has_pareng_group, default: proc { false }
    option :hierarchical_name, default: proc { nil }
    option :group_name, default: proc { nil }
    option :group_dom_id, default: proc { "" }
    option :selector_group_type, default: proc { "deviceGroup" }

end
  