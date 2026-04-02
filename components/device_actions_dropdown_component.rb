class DeviceActionsDropdownComponent < ViewComponent::Base
  attr_reader :device
  attr_reader :user
  attr_reader :platform_feature_enabled

  include ApplicationHelper

  def initialize(device:, user:, platform_feature_enabled:)
    @device = device
    @user = user
    @platform_feature_enabled = platform_feature_enabled
  end

  def is_android
    device.os_type == 'android'
  end

  def is_mac 
    device.os_type == 'macos'
  end

  def is_ios
    device.os_type == 'ios'
  end

  def is_windows
    device.os_type == 'windows'
  end

  def is_byod
    device.mode != 'byod'
  end

  def is_chromeos
    device.os_type == 'chromeos'
  end

  def is_nix
    device.os_type == 'nix'
  end

  def is_printer
    device.os_type == 'printer'
  end

  def is_tvos
    device.os_type == 'tvos'
  end

  def can_show_lost_option
      device.activated &&  show_apple_actions && !device.lost_mode_applied
  end

  def can_show_unmark_lock_option
      device.activated && show_apple_actions && device.lost_mode_applied
  end

  def chromeos_can_show_lost_option
    device.activated && show_chromeos_actions && !device.lost_mode_applied
  end

  def chromeos_can_show_unmark_lost_option
    device.activated && show_chromeos_actions && device.lost_mode_applied
  end

  def can_show_android_lost_option
    is_android && device.emm_managed && !is_byod && !device.factory_reset && device.activated
  end

  def can_reboot
    device.activated && (is_mac && !is_byod ? true : device.rebootable?) && (is_chromeos ? show_chromeos_actions : true) && (is_printer ? show_printer_actions : true)
  end

  def show_apple_actions
    is_ios && device.is_supervised
  end 

  def show_chromeos_actions
    is_chromeos && !device.factory_reset && !device.deprovisioned
  end

  def show_printer_actions(action_name = nil)
    return false unless is_printer && !device.factory_reset
  
    # Determines if model-specific actions like "Print Test Page" and "Shutdown" should be hidden
    if [:shutdown].include?(action_name) && device.make.downcase == 'zebra'
      device.model == Emm::Printer::PrinterDeviceProfile::ZEBRA_PRINTER_MODELS[:zd_630]
    else
      true
    end
  end

  def in_active
    device.activated && is_windows ? device.inactive?(nil, device.last_updated_at) : device.inactive?
  end 

  def show_clear_browser_cache
    device.supports_mlp_clear_browser_cache? && device.activated
  end

  def can_lock_unlock
    return false if is_chromeos || is_printer
    if (is_byod && is_android)
      false
    end
    if (is_ios || is_mac || is_tvos) 
        !!device.device_profile_id
     else 
        return true
     end
  end

  def can_assign_user
    device.activated? && (device.enrollment_user_id.nil? || device.organization_user_device.nil?) && device.mode != 'byod' && !is_printer
  end

  def can_show_add_user
    !is_chromeos && !is_printer && !is_tvos
  end

  def is_apn_expired?
    if is_mac || is_ios || is_tvos
      return device&.state == 'apns_expired'
    else
      return false
    end
  end

  # check if device related action can be performed or not?
  # check if device is factory reseted or the device owner apn is expired
  def can_perform_action?
    if is_apn_expired?
      return false
    else
      return device.factory_reset ? false : platform_feature_enabled
    end
  end
end
  