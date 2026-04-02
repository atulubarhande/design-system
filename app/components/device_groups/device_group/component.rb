# frozen_string_literal: true

class DeviceGroups::DeviceGroup::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  include ApplicationHelper
  include V3::DeviceGroupsHelper
  option :device_group, default: proc { Hash.new }
  option :group_device_counts, default: proc { nil }
  option :group_user_counts, default: proc { nil }
  option :org_unit_counts, default: proc { nil }
  option :select_multiple, default: proc { false }
  option :disabled_selected_group, default: proc { nil }
  option :published_group_ids, default: proc {[]}

  def parent_dom_selector
    selector = ""
    selector = "DeviceGroup" if @device_group.is_a?(DeviceGroup)
    selector = "OrganizationUserGroup" if @device_group.is_a?(OrganizationUserGroup)
    selector = "OrganizationUnit" if @device_group.is_a?(OrganizationUnit)
    selector
  end

  def disabled_selected_groups(id)
    if !@disabled_selected_group.nil?
      (@disabled_selected_group.include?(id.to_s.split("-").last)) ? true : false
    end
  end

end
    