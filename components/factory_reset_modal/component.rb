# frozen_string_literal: true

class FactoryResetModal::Component < ApplicationViewComponent

  include Turbo::FramesHelper
  include ApplicationHelper

  def initialize(device: nil, is_sf_account: true, printer_reset_options: nil)
    @device = device
    @is_sf_account = is_sf_account
    @printer_reset_options = printer_reset_options
  end

  def is_chrome_os?
    @device.chromeos?
  end

  def is_printer?
    @device.printer?
  end

  def printer_provider_type
    @device.device_conductor_config.provider_type == 'zebra' ? 'zebra' : 'brother'
  end

  def is_nix?
    @device.nix?
  end
    
end
  