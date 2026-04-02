# frozen_string_literal: true
class DeviceOptions::Component < ApplicationViewComponent
  include DevicesHelper
  attr_reader :device
  option :device, default: proc { nil }
  option :current_user, default: proc { nil }

  def can_change_exit_pass_code?
    if device.os.downcase == 'android' && has_permission?('Device-ViewExitPasscode')
      !(device&.device_profile_id || device&.mode == 'byod')
    else
      false
    end
  end

  def has_permission?(slug)
    @current_user&.permissions.include?(slug)
  end

  def policy_text_applicable?()
    return mac_device? || (device.mode == 'byod' && ios_device?)
  end

  def mac_device?
    device.os_type.downcase == 'macos'
  end

  def android_device?
    device.os_type.downcase == 'android'
  end

  def ios_device?
    device.os_type.downcase == 'ios'
  end

  def windows?
    device.os_type.downcase == 'windows'
  end

  def lock_unlock_tooltip_msg()
    return device&.lost_mode_applied ? I18n.t('devices.lostMode.lock_unlock_note') : ''
  end

  def lock_unlock?()
    # Cannot lock/unlock BYOD Android device
    return false if device&.mode == 'byod' && android_device?
  
    # For iOS or Mac devices
    if ios_device? || mac_device?
      return device&.device_profile&.id.present?
    else
      return true
    end
  end

  def enable_clear_lock?()
    # Check if the device is activated and supervised
    if device&.activated && device.try(:is_supervised)
      # For Mac devices, return false if activation lock is not supported
      if mac_device? && !device&.activation_lock_supported
        return false
      else
        return true
      end
    else
      return false
    end
  end

  def  show_clear_browser_cache?()
    return device&.mode != "user_enrolled" && device&.supports_mlp_clear_browser_cache? && has_permission?('BrowserShortcut')
  end

  def system_logs_supported?
    return device&.system_logs_supported? if windows?
    return device&.becomes(MacDevice).system_logs_supported? if mac_device?
  
    false
  end

  def enable_log_menu?
    logs_supported_app_version_code = android_device? && AndroidDevice::LOGS_SUPPORTED_VERSION_CODE
    android_supported = android_device? &&
                        compare_versions(device&.os_version, '7.0', '>=') &&
                        device&.knox_info_device_owner_enabled &&
                        device&.mode != 'byod' &&
                        device&.app_version_code.present? &&
                        device&.app_version_code > logs_supported_app_version_code
    
    system_supported = system_logs_supported?
  
    android_supported || system_supported
  end

  # Helper method for comparing version strings
  # def compare_versions(version1, version2, operator)
  #   return nil if version1.nil? || version2.nil? || operator.nil?
  
  #   begin
  #     v1 = version1.is_a?(String) ? version1[/\d+\.\d+\.\d+\.\d+/] : nil
  #     v2 = version2.is_a?(String) ? version2[/\d+\.\d+\.\d+\.\d+/] : nil
  
  #     return nil if v1.nil? || v2.nil?
  
  #     Gem::Version.new(v1).public_send(operator, Gem::Version.new(v2))
  #   rescue ArgumentError, NoMethodError => e
  #     nil
  #   end
  # end

  def compare_versions(version1, version2, operator)
    return nil if version1.nil? || version2.nil? || operator.nil?
  
    begin
      v1 = Gem::Version.new(version1.to_s)
      v2 = Gem::Version.new(version2.to_s)
      v1.public_send(operator, v2)
    rescue ArgumentError, NoMethodError => e
      nil
    end
  end

  def show_mark_lock_option
    (show_apple_actions? || windows? || (device&.android? && device&.mode != 'byod' && !device&.factory_reset?)) && !device&.lost_mode_applied
  end

  def show_unmark_lock_option
    (show_apple_actions? || windows?) && device&.lost_mode_applied
  end

  def show_apple_actions?
    ios_device? && device&.is_supervised
  end

  def show_lost_option
    android_device? && device&.mode != 'byod' && !device&.factory_reset && device&.activated && device.lost_mode_applied
  end

  def can_factory_reset()
    return device&.knox_info&.factory_reset_supported if [true, false].include?(device&.knox_info&.factory_reset_supported)
  
    if cope_device?()
      true
    elsif android_device?
      (device&.knox_info_device_admin_activated || device&.emm_managed) && device&.mode != 'byod'
    elsif mac_device?
      true
    elsif ios_device?
      true
    else
      true
    end
  end

  def cope_device?()
    android_device? && device[:mode] == 'byod' && device[:cope_enabled]
  end

  def rebootable_device?
    mac_device? && device&.mode != 'byod' ? true : device&.rebootable?
  end

  def show_reset_password_option
    # If the device is COPE-enabled and does not allow password removal, show the reset password option
    return true if cope_device? && !device&.allow_remove_password
  
    # If the OS version is >= 8.0 and the device is not EMM-managed, do not show the option
    if compare_versions(device[:os_version], '8.0', '>=')
      return false unless device&.emm_managed
    end
  
    android_device? &&
      !device&.allow_remove_password &&
      device[:mode] != 'byod' &&
      !device&.admin_configured_password
  end
  
  def show_remove_password_option()
    # !!(device[:passcode_applied] || device[:allow_remove_password])
    @device&.passcode_locked? || @device&.allow_remove_password
  end

  def owner
    current_user.admin_parent
  end

  def shutdown_suported?
    mac_device? || show_apple_actions? || (windows? && device.shutdown_supported?) || (android_device? && device&.mode != 'byod')
  end

  def shutdown_tooltip_msg
    msg = ""
    if android_device? 
      if !(['lenovo', 'samsung'].include?(device&.make&.downcase)) && !(@device.shutdown_supported? || @device.wingman_installed?)
        msg = t('devices.detail_menu.shutdown_device.make_not_supported_tooltip');
      elsif  AndroidDevice::SHUTDOWN_SUPPORTED_VERSION_CODE && device[:app_version_code] <  AndroidDevice::SHUTDOWN_SUPPORTED_VERSION_CODE.to_i
        msg = t('devices.detail_menu.shutdown_device.update_sf_version_tooltip');
      elsif !(@device.shutdown_supported? || @device.wingman_installed?)
        msg = t('devices.detail_menu.shutdown_device.shutdown_supported');
      end
    end
    msg
  end

  def is_apn_expired?
    if mac_device? || ios_device?
      return device&.state == 'apns_expired'
    else
      return false
    end
  end

  def platform_feature_enabled
    if android_device?
      return owner.user_subscription.android
    elsif ios_device? || device&.shared_ipad?
      return owner.user_subscription.ios
    elsif mac_device?
      return owner.user_subscription.macos
    elsif windows?
      return owner.user_subscription.windows
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
  