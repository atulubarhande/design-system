# frozen_string_literal: true
class DeviceAppsListComponent < ViewComponent::Base
  include Turbo::FramesHelper
  renders_one :list, ListItemComponent
  renders_one :new_device_frame, NewDeviceFrameComponent
  renders_one :modal, ModalComponent  
  renders_one :card, CardComponent
  def initialize(device:)
    @device = device
  end

end
