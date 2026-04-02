# frozen_string_literal: true

class Devices::Device::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  include ApplicationHelper
  include V3::DeviceGroupsHelper
  attr_reader :device

  option :device, default: proc { Hash.new }
  option :name_attr, default: proc { nil }
  option :select_multiple, default: proc { nil }

  def device_name
    device&.device_name || device&.name
  end
end
    