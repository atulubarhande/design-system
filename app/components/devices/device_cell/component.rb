# frozen_string_literal: true

class Devices::DeviceCell::Component < ApplicationViewComponent
  include ApplicationHelper
  include DevicesHelper
  include V3::DevicesHelper
  attr_reader :device
  attr_reader :current_user
  option :device, default: proc { nil }
  option :header_slug, default: proc { nil }
  option :custom_headers_list, default: proc { nil }
  option :geofence_workflow_available, default: proc { nil }
  option :owner, default: proc { nil }
  option :current_user, default: proc { nil }

  def device_profile_name()
    profile = @geofence_workflow_available ? device&.set_geofence_device_profile : nil
    return profile.present? ? profile.name : device&.device_profile&.name
  end

  def has_ethernet_signal(device)
    ["ethernet"].include?(device&.network_type&.downcase)
  end

  def sim_signal_class(device)
    if(device&.sim_signal_strength)
      signal_value = device&.sim_signal_strength.to_i
      if signal_value >= 4
        return 'device_signal_four'
      elsif signal_value == 3
        return 'device_signal_three'
      elsif signal_value == 2
        return 'device_signal_two'
      elsif signal_value == 1
        return 'device_signal_one'
      end
    end
    # return 'device_signal_zero'
  end

  def wifi_signal_class(device)
    case device&.wifi_signal_strength.to_i
    when 1
      'wifi_signal_one'
    when 2
      'wifi_signal_two'
    when 3
      'wifi_signal_three'
    when 4
      'wifi_signal_four'
    else
      'wifi_signal_one'
    end
  end

  def wifi_signal_strength(device) 
    if([0, 1].include?(device&.wifi_signal_strength)) 
      return I18n.t('full_device_info.connection_status.weak')
      elsif(device&.wifi_signal_strength == 2)
        return I18n.t('full_device_info.connection_status.fair')
      elsif(device&.wifi_signal_strength == 3)
        return I18n.t('full_device_info.connection_status.good')
      elsif(device&.wifi_signal_strength == 4)
        return I18n.t('full_device_info.connection_status.excellent')
    end
  end


  def signal_strength_status_sim1(sim_signal_strength)
    if (sim_signal_strength.present?)
      signal_value = sim_signal_strength.to_i
      if signal_value >= 5
        return I18n.t('full_device_info.connection_status.excellent')
      elsif signal_value == 4
        return I18n.t('full_device_info.connection_status.great')
      elsif signal_value == 3
        return I18n.t('full_device_info.connection_status.good')
      elsif signal_value == 2
        return I18n.t('full_device_info.connection_status.fair')
      elsif signal_value == 1
        return I18n.t('full_device_info.connection_status.poor')
      end
    end
  end

  def app_version_name(device)  
    (device&.app_version_code.present? ? "#{device&.app_version_name}(#{device&.app_version_code})" : device&.app_version_name)
  end

  def is_wifi_signal(device)
    ["WIFI", "wifi"].include?(device&.network_type&.downcase) 
  end

  def is_wifi_signal_strength(device)
    wifi_signal_strength = device&.wifi_signal_strength.nil? ? -1 : device&.wifi_signal_strength
    wifi_signal_strength > -1
  end

  def has_network_signal(device)
    ["2G", "3G", "4G", "5G", "Unknown"].include?(device&.network_type) && device&.os == 'Android'
  end

  def date_format(date_time)
    if date_time != nil
      date_time = date_time.to_time if date_time.is_a?(Date)
      local_offset = Time.now.utc_offset
      date_time = date_time.localtime(local_offset) if date_time.respond_to?(:localtime)
      return date_time.strftime("%-d %b %Y, %l:%M %P")
    else
      return I18n.t('common.na')
    end
  end

  def has_custom_field_key(slug)
    return ['device_status',
      'battery_status',
      'device_storage',
      'external_storage',
      'updated_at',
      'created_at',
      'last_power_on_time',
      'last_power_off_time',
      'device_mac_address',
      'device_group',
      'password_compliant',
      'rooted',
      'ram_usage',
      'device_profile',
      'build_version',
      'management_agent',
      'enrollment_method',
      'enrollment_type',
      'fde_enabled',
      'device_firmware',
      'ip_address',
      'status',
      'app_version_name',
      'management_mode',
      'management_type',
      'device_model_name',
      'power_status',
      'enabled_system_integrity_protection',
      'efi_password_exists',
      'enabled_via_dep',
      'user_approved_enrollment',
      'data_roaming_enabled',
      'data_roaming_enabled_2',
      'voice_roaming_enabled',
      'voice_roaming_enabled_2',
      'onboarding_email',
      'bluetooth_mac',
      'firewall',
      'skin_temp',
      'serial_no',
      'build_serial_no',
      'gsm_serial_no',
      'battery_temp',
      'cpu_temp',
      'cpu_usage',
      'ethernet_mac',
      'gsuite_account',
      'host_name',
      'device_encryption_status',
      'public_ip',
      'connection_status',
      'connection_info',
      'os_version',
      'model',
      'make'
    ].include?(slug)
  end 

  def has_custom_field_key_for_windows(slug)
    return[
      'antispyware',
      'antivirus',
      'dm_client_version',
      'device_type',
      'hardware_id',
      'machine_name',
      'os_version_name',
      'resolution',
      'vPro_amt_status',
      'domain_name',
      'name',
      'processor_type'
    ].include?(slug)
  end
  
  def add_class_for_unlicenced_devices(device_status)
    return device_status == "UNLICENSED" && !@owner.in_trial?
  end
end
  