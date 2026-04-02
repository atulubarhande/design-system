# frozen_string_literal: true
class DeviceCardHeader::Component < ApplicationViewComponent
  include DevicesHelper
  attr_reader :device
  option :device, default: proc { Hash.new }
  option :current_user, default: proc { nil }
end
  