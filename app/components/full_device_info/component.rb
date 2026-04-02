# frozen_string_literal: true
class FullDeviceInfo::Component < ApplicationViewComponent
  include DevicesHelper
  include DeviceProfilesHelper
  include ApplicationHelper

  attr_reader :device
  option :device, default: proc { nil }
  option :current_user, default: proc { nil }
  option :enforced_apple_os_update, default: proc { nil }

  def os_zmdi_icon()
    os_type_icons = {
      'android' => 'zmdi-android',
      'ios' => 'zmdi-apple',
      'macos' => 'zmdi-desktop-mac',
      'windows' => 'zmdi-windows',
      'ipad' => 'zmdi-tablet-mac'
    }
    os_type_icons[device.os_type]
  end

  def screen_resolution()
    if device&.screen_height && device.screen_width
      "#{device&.screen_height} X #{device&.screen_width} px"
    else
      I18n.t('common.na')
    end
  end

  def get_imei_number()
    imei_number_sim1 = device&.imei_no.present? ? device&.imei_no : I18n.t('common.na')
    imei_number_sim2 = device&.imei_no_2.present? ? device&.imei_no_2 : I18n.t('common.na')
  
    if device.ios? || device.android?
      html = "<span><b>SIM </b><i class='zmdi zmdi-n-1-square'></i> : #{imei_number_sim1}" \
             "<br/><span><b>SIM </b><i class='zmdi zmdi-n-2-square'></i> : #{imei_number_sim2}</span>"
      html.html_safe
    else
      I18n.t('common.na')
    end
  end

  def get_imsi_number()
    imsi_number_sim1 = device&.imsi_no.present? ? device&.imsi_no : I18n.t('common.na')
    imsi_number_sim2 = device&.imsi_no_2.present? ? device&.imsi_no_2 : I18n.t('common.na')
    case device.os_type
    when 'android'
      html = "<span><b>SIM </b><i class='zmdi zmdi-n-1-square'></i> : #{imsi_number_sim1}" \
             "<br/><span><b>SIM </b><i class='zmdi zmdi-n-2-square'></i> : #{imsi_number_sim2}</span>"
      html.html_safe
    else
      I18n.t('common.na')
    end
  end

  def get_iccid_number()
    iccid_number_sim1 = device&.iccid_no.present? ? device&.iccid_no : I18n.t('common.na')
    iccid_number_sim2 = device&.iccid_no_2.present? ? device&.iccid_no_2 : I18n.t('common.na')
    
    if device.ios? || device.android?
      html = "<span><b>SIM </b><i class='zmdi zmdi-n-1-square'></i> : #{iccid_number_sim1}" \
             "<br/><span><b>SIM </b><i class='zmdi zmdi-n-2-square'></i> : #{iccid_number_sim2}</span>"
      html.html_safe
    else
      I18n.t('common.na')
    end
  end

  def get_phone_number()
    phone_number_sim1 = device&.phone_no.present? ? device&.phone_no : I18n.t('common.na')
    phone_number_sim2 = device&.phone_no_2.present? ? device&.phone_no_2 : I18n.t('common.na')
    
    if device.ios? || device.android?
      html = "<span><b>SIM </b><i class='zmdi zmdi-n-1-square'></i> : #{phone_number_sim1}" \
             "<br/><span><b>SIM </b><i class='zmdi zmdi-n-2-square'></i> : #{phone_number_sim2}</span>"
      html.html_safe
    else
      I18n.t('common.na')
    end
  end


  def get_enrollment_status
    if device.windows?      
      if device&.response_code
        status = t("windows.status_code.#{device&.response_code}") || 'N/A'
        hint = t("windows.status_code.#{device&.response_code}_hint") || 'N/A'
        
        "<span>#{status}<i class='zmdi zmdi-info zmdi-hc-lg m-l-5 c-blue' title='#{hint}'></i></span>".html_safe
      elsif device.state == 'mdm_managed'
        t('common.success_not_configured')
      else
        t('common.not_yet_configured')
      end
    end
  end

  def safe_mode_device_encrypted
    if device&.os_type == 'android'
      device&.device_encrypted? ? I18n.t('common.text_yes') : I18n.t('common.text_no')
    else
      false
    end
  end

  def visible_info_device_info?
    return false unless device.windows?
 
    device.windows? && !device.hardware_inventory_supported?
  end

  def show_battery_health?
    return false if device.windows? && device.hardware_inventory_supported?

    ['android', 'windows', 'macos', 'ios'].include?(device.os.downcase)
  end

  def safe_mode_info
    if device&.os_type == 'android'
      device.safe_mode_passcode_protected? ? device.safe_mode_passcode : I18n.t('common.na')
    end 
  end

  def wifi_data
    static_mac = device.wifi_mac_address || I18n.t('common.na')
    randomized_mac = device.connected_wifi_random_mac_address
    randomized_mac_display = randomized_mac.present? ? randomized_mac : I18n.t('common.na')
  
    result = "#{I18n.t('common.static')}: #{static_mac}<br>"
    if device&.android? || device&.windows?
      result += "#{I18n.t('common.randomized')}: #{randomized_mac_display}"
    end 
    result.html_safe
  end  

  def battery_status(device)
    return I18n.t('common.not_available') unless device&.battery_status.present?
  
    battery_status = device.battery_status
    charging = device&.charging
  
    if battery_status == 0
      "#{battery_status} #{I18n.t('common.per_left')}"
    elsif battery_status == 100
      if charging
        "#{battery_status}#{I18n.t('common.per_left')} | #{I18n.t('common.charging')}"
      else
        "#{battery_status}#{I18n.t('common.per_left')} | #{I18n.t('common.charged')}"
      end
    else
      "#{battery_status} #{I18n.t('common.per_left')}"
    end    
  end 

  def battery_temp
    if device&.android?    
      if (device&.battery_temp || 0) > 0
        device&.battery_temp.to_s + t('common.celsius')
      else
        t('common.na');
      end
    end 
  end

  def tpm_chip_version
    if device&.windows? 
      if device&.tpm_chip_version.present?
        device.tpm_chip_version.split(",").first
      else
        I18n.t('common.na')
      end
    end
  end 
  
  def processor_details
    if device&.windows? 
      if device&.processor_details 
        '<div><div>Name:' + (device&.processor_details['name'] || I18n.t('common.na')) +'</div><div>Manufacturer:' + (device&.processor_details['manufacturer'] || I18n.t('common.na')) + '</div></div>' 
      else 
        I18n.t('common.na')
      end
    end 
  end
    
  def bios_details
    if device&.windows?
      if device&.bios_details && device&.bios_details['manufacturing_date'] 
        '<div>Date:' + (device&.bios_details['manufacturing_date']) + '</div>' 
      else 
        I18n.t('common.na')
      end
    end
  end 

  def intel_vpro(device)
    {
      intel_vpro_status: device.intel_vpro_device_mapping&.status || 'unknown',
      power_status: power_status(device),
      mebx_password: device.intel_vpro_device_mapping&.mebx_password
    }
  end
  
  def power_status(device)
    power_state(device.power_status, device.charging)
  end
  
  def bios_mebx_password
    if device&.windows?
      device&.intel_vpro_device_mapping&.mebx_password || I18n.t('common.na')
    end
  end

  def serial_number
    build_serial_no = ""
    gsm_serial_no = ""
  
    if device&.build_serial_no
      build_serial_no = '<div><b>' + t('devices.build_serial_no') + '</b>: ' + device&.build_serial_no + '</div>'
    end
  
    if device&.gsm_serial_no
      gsm_serial_no = '<div><b>' + t('devices.gsm_serial_no') + '</b>: ' + device&.gsm_serial_no + '</div>'
    end
  
    '<div><div><b>' + t('devices.serial_nos') + '</b>: ' + (device&.serial_no || I18n.t('common.na')) + '</div>' +
      build_serial_no + gsm_serial_no + '</div>'
  end

  def cpu_temp 
    if device&.android?
      if(device&.cpu_temp) 
        device&.cpu_temp.to_s + t('common.celsius')
      else 
        t('common.na')
      end 
    end 
  end

  # There is only 6 to 7 or max 12 records can present.
  def cpu_usage_data
    cpu_data = device.cpu_usage_infos

    return t('common.na') unless cpu_data.present?
    
    overall_data = "#{cpu_data.find_by(name: "_Total")&.usage || 0}%"

    individual_data = cpu_data.where.not(name: "_Total")
        .order(:name)
        .pluck(:name, :usage)
        .map { |name, usage| "CPU#{name}: #{usage}%" }
        .join(", ")

    "<div><div>Overall:#{overall_data}</div><div>Individual - #{individual_data}</div></div>"    
  end

  def ram_usage_data
    ram_data = device.ram_usage_info

    return t('common.na') unless ram_data.present?

    total_ram = formatted_storage_capacity(ram_data.total_mb, device.os_type)
    ram_used = formatted_storage_capacity(ram_data.used_mb, device.os_type)


    "<div><div>Total Capacity:#{total_ram}</div><div>Used - #{ram_used}</div></div>"    
  end

  def ram_usage
    ram_used = formatted_storage_capacity(device&.ram_usage, device&.os_type)
    total_ram = formatted_storage_capacity(device&.total_ram_size, device&.os_type)

    if ram_used && total_ram
      if ram_used == 'N/A' || total_ram == 'N/A' 
        t('common.na');
      else
        ram_used + " / " + total_ram
      end
    else
      t('common.na');
    end
  end

  def screen_temp    
    if device&.android?
      if device&.skin_temp
        device&.skin_temp.to_s + t('common.celsius')
      else 
        t('common.na')
      end 
    end  
  end 

  def format_set_unset
    if device&.macos?
      if device&.efi_password_exists
        t("common.set")
      elsif device&.efi_password_exists == false
        t("common.not_set")
      else 
        t("common.na")
      end 
    end
  end

  def voice_roaming_status
    voice_roaming_status_sim1 = enabled_disabled(@device&.voice_roaming_enabled) || t('common.na')
    voice_roaming_status_sim2 = enabled_disabled(@device&.voice_roaming_enabled_2) || t('common.na')

    if device&.android?
      "<div><div><b>SIM </b><i class='zmdi zmdi-n-1-square'></i>: " + voice_roaming_status_sim1 + "</div><div><b>SIM </b><i class='zmdi zmdi-n-2-square'></i>: " + voice_roaming_status_sim2 + "</div></div>"
    else
      value_map = {
        true => t("common.text_yes"),
        false => t("common.text_no"),
        nil => t("common.na")
      }

      value_map[enabled_disabled(@device.voice_roaming_enabled)]
    end
  end 

  def data_roaming_status
    data_roaming_status_sim1 = enabled_disabled(@device.data_roaming_enabled) || t('common.na')
    data_roaming_status_sim2 = enabled_disabled(@device.data_roaming_enabled_2) || t('common.na')

    if device&.android?
      "<div><div><b>SIM </b><i class='zmdi zmdi-n-1-square'></i>: " + data_roaming_status_sim1 + "</div><div><b>SIM </b><i class='zmdi zmdi-n-2-square'></i>: " + data_roaming_status_sim2 + "</div></div>"
    else
      value_map = {
        true => t("common.text_yes"),
        false => t("common.text_no"),
        nil => t("common.na")
      }
      value_map[enabled_disabled(@device.data_roaming_enabled)]
    end
  end

  def signal_strength
    signal_strength_title_sim1 = @device&.sim_signal_strength.present? ? signal_strength_status_sim(@device&.sim_signal_strength) : t('common.na')
    signal_strength_title_sim2 = @device&.sim_signal_strength_2.present? ? signal_strength_status_sim(@device&.sim_signal_strength_2) : t('common.na')

    sim_network1 = @device&.sim1_network_type || ''
    sim_network2 = @device&.sim2_network_type || ''

    if @device&.sim_signal_strength.present? && @device&.sim_signal_strength.to_i > 0
      show_signal_strength_sim1 = @device&.sim_signal_strength.nil? ?
            "<span>" + signal_strength_title_sim1 + "</span>"  :
            "<span class='signal-strength " + sim_signal_class(@device&.sim_signal_strength.to_i) + "' title='" + signal_strength_status_sim(@device&.sim_signal_strength.to_i) + "'></span>";
    else
      show_signal_strength_sim1 = "<i class='zmdi zmdi-network-off zmdi-hc-lg m-r-5' title='No Mobile Data'></i>"
    end 

    if @device&.sim_signal_strength_2.present? && @device&.sim_signal_strength_2.to_i > 0
      show_signal_strength_sim2 = @device&.sim_signal_strength_2.nil? ?
            "<span>" + signal_strength_title_sim2 + "</span>"  :
            "<span class='signal-strength " + sim_signal_class(@device&.sim_signal_strength_2.to_i) + "' title='" + signal_strength_status_sim(@device&.sim_signal_strength_2.to_i) + "'></span>"
    else
      show_signal_strength_sim2 = "<i class='zmdi zmdi-network-off zmdi-hc-lg m-r-5' title='No Mobile Data'></i>"
    end

    "<span><b>SIM </b><i class='zmdi zmdi-n-1-square'></i> : " + show_signal_strength_sim1 + sim_network1 + "<br/><span><b>SIM </b><i class='zmdi zmdi-n-2-square'></i> : " + show_signal_strength_sim2 + sim_network2 
  end 

  def sim_signal_class(signal_strength)  
    signal_value = signal_strength.to_i
    if signal_value >= 4
      'device_signal_four'
    elsif signal_value == 3
      'device_signal_three'
    elsif signal_value == 2
      'device_signal_two'
    elsif signal_value == 1
      'device_signal_one'
    else
      'device_signal_zero'
    end
  end  

  def signal_strength_status_sim(signal_strength)
    return nil unless signal_strength.present?
    signal_value = signal_strength.to_i
    if signal_value >= 5
      t('full_device_info.connection_status.excellent')
    elsif signal_value == 4
      t('full_device_info.connection_status.great')
    elsif signal_value == 3
      t('full_device_info.connection_status.good')
    elsif signal_value == 2
      t('full_device_info.connection_status.fair')
    elsif signal_value >= 0
      t('full_device_info.connection_status.poor')
    end
  end 
  
  def network_operator
    network_operator_sim1 = @device&.sim_network.present? ? @device&.sim_network : t('common.na')
    network_operator_sim2 = @device&.sim_network_2.present? ? @device&.sim_network_2 : t('common.na')

    "<span><b>SIM </b><i class='zmdi zmdi-n-1-square'></i> : " + network_operator_sim1 + "<br/><span><b>SIM </b><i class='zmdi zmdi-n-2-square'></i> : " + network_operator_sim2
  end 

  def sim_card_available
    if @device&.phone_no.present? || @device&.phone_no_2.present?
      sim1 = @device&.phone_no.present? ? @device&.phone_no : 'Not Available'
      sim2 = @device&.phone_no_2.present? ? @device&.phone_no_2 :  'Not Available'

      "<span><b>SIM </b><i class='zmdi zmdi-n-1-square'></i> : " + sim1 + "<br/><span><b>SIM </b><i class='zmdi zmdi-n-2-square'></i> : " + sim2
    else
      t('common.na')
    end 
  end

  def wifi_strength
    wifi_strength_title = @device&.wifi_signal_strength.present? ? @device&.wifi_signal_strength : t('common.na')

    if @device&.wifi_signal_strength.to_i > -1
      show_wifi_strength = @device&.wifi_signal_strength.nil? ?
        "<span>" + wifi_strength_title + "</span>"  :
        "<span class='signal-strength " + wifi_signal_class + "' title='" + wifi_signal_strength + "'></span>"
    else 
      show_wifi_strength = "<i class='zmdi zmdi-wifi-off zmdi-hc-lg' title='Not Connected'></i>"
    end    
  end

  def wifi_signal_class
    case @device&.wifi_signal_strength.to_i
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

  def wifi_signal_strength
    case @device&.wifi_signal_strength.to_i
    when 0, 1
      t('full_device_info.connection_status.weak')
    when 2
      t('full_device_info.connection_status.fair')
    when 3
      t('full_device_info.connection_status.good')
    when 4
      t('full_device_info.connection_status.excellent')
    else
      t('full_device_info.connection_status.weak')
    end
  end
  
  def get_meid
    meid1 = @device&.meid_1 ? @device&.meid_1 : t('common.na')
    meid2 = @device&.meid_2 ? @device&.meid_2 : t('common.na')

    "<div><div><b>SIM </b><i class='zmdi zmdi-n-1-square'></i>: " + meid1 + "</div><div><b>SIM </b><i class='zmdi zmdi-n-2-square'></i>: " + meid2 + "</div></div>"
  end

  def get_roaming_status
    value_map = {
      true => t("common.text_yes"),
      false => t("common.text_no"),
      nil => t("common.na")
    }
    roaming_status_sim1 = value_map[@device&.roaming]
    roaming_status_sim2 = value_map[@device&.roaming_2]

    "<div><div><b>SIM </b><i class='zmdi zmdi-n-1-square'></i>: " + roaming_status_sim1 + "</div><div><b>SIM </b><i class='zmdi zmdi-n-2-square'></i>: " + roaming_status_sim2 + "</div></div>"
  end

  def current_carrier_network
    if @device&.ios?
      current_carrier_network1 = @device&.current_network || t('common.na')
      current_carrier_network2 = @device&.current_network_2 || t('common.na')

      "<span><b>SIM </b><i class='zmdi zmdi-n-1-square'></i> : " + current_carrier_network1 + "<br/><span><b>SIM </b><i class='zmdi zmdi-n-2-square'></i> : " + current_carrier_network2
    end 
  end

  def wifi_ssid
    return unless @device
  
    ssid = @device.connected_wifi_ssid
    mac_address = @device.connected_wifi_mac_address if @device.android?
  
    if @device.android? || @device.windows?
      ssid.to_s + (mac_address.to_s if mac_address.present?).to_s
    end
  end

  def get_enrolled_user_info
    if @device&.windows? || @device&.macos?
      if @device&.windows?
        enroll_user_data = @device.enroll_user_data
      end 
      if @device&.macos?
        enroll_user_data = @device.enrolled_user_info&.slice(:name, :group, :apple_id) rescue nil
      end 
      if enroll_user_data
        username =  enroll_user_data.public_send(:[], :name) || t('common.na')
        group    =  enroll_user_data.public_send(:[], :group) || t('common.na')
        "<span><b>Enrolled User </b><i class='zmdi'></i> : " + username + "<br/><span><b> Group </b><i class='zmdi '></i> : " + group
      end 
    end
  end
  
  def wifi_frequency_band
    if @device&.android? && device&.wifi_frequency_band.present?
      Integer(device&.wifi_frequency_band) > 0 ? device&.wifi_frequency_band : t('common.na')
    end
  end 
  
  def management_info_tabs
    [
      {
          title: I18n.t('common.device_name'),
          data: device&.name || I18n.t('common.na'),
          icon: 'zmdi-laptop',
          visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.enrollment_mode'),
          data: enrollment_mode,
          icon: 'zmdi-smartphone',
          visible: ['android', 'ios', 'macos', 'windows'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.enrollment_email'),
          data: enrollment_email || I18n.t('common.na') ,
          icon: 'zmdi-email',
          visible: ['android', 'ios', 'macos', 'windows'].include?(device.os.downcase)
      },
      {
          title: device&.user_group.present? ? I18n.t('common.user_group_name') : I18n.t('common.device_group_name'),
          data: (device&.device_group.present? ? device&.device_group.name : (device&.user_group.present? ? device&.user_group.name : I18n.t('v2.groups.not_assigned'))) || I18n.t('common.na'),
          icon: 'zmdi-group',
          visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.brand_name'),
          data: device&.brand&.name || I18n.t('v2.brands.not_applied'),
          icon: 'zmdi-image-o',
          visible: ['android', 'ios', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.device_profile_name'),
          data: device&.device_profile&.name || I18n.t('v2.profiles.not_assigned'),
          icon: 'zmdi-devices',
          visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
          title: I18n.t('common.last_seen'),
          data: @device.windows? ? time_ago_in_words(@device.last_updated_at) : time_ago_in_words(@device.last_connected_at) + " ago" || I18n.t('common.na'),
          icon: 'zmdi-time',
          visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.managed_user'),
          data: device&.macos? && device.becomes(MacDevice).user_long_name || I18n.t('common.na'),
          icon: 'zmdi-account',
          visible: ['macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('common.enrollment_method'),
          data: device&.device_property&.enrollment_method ? I18n.t('common.'+device&.device_property&.enrollment_method) : I18n.t('common.unknown'),
          icon: 'zmdi-smartphone',
          visible: ['android', 'ios', 'macos', 'windows'].include?(device.os.downcase)
      },
      {
          title: I18n.t('v2.licenses.license_status'),
          data: device&.status || I18n.t('common.na'),
          icon: 'zmdi-code-setting',
          visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
          title: I18n.t('v2.licenses.license_code'),
          data: device&.licence&.code.present? && permitted_licence_code(device&.licence&.code).scan(/.{1,4}/).join("-") || '',
          icon: 'zmdi-key',
          visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.power_on_time'),
          data: device&.last_power_on_time ? date_custom_format(device&.last_power_on_time) : I18n.t('common.na'),
          icon: 'zmdi-power',
          visible: ['android', 'windows'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.power_off_time'),
          data: device&.last_power_off_time ? date_custom_format(device&.last_power_off_time) : I18n.t('common.na'),
          icon: 'zmdi-power-off',
          visible: ['android', 'windows'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.management_agent'),
          data: device&.device_manager&.titleize || I18n.t('common.na'),
          icon: 'zmdi-face',
          visible: ['android'].include?(device.os.downcase)
      },
      {
          title: I18n.t('common.location_permission'),
          data: location_permission,
          icon: 'zmdi-pin',
          visible: ['ios', 'macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('common.notification_permission'),
          data: notification_permission,
          icon: 'zmdi-notifications-active',
          visible: ['ios', 'macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('common.auto_enroll_mdm'),
          data: get_enrollment_status,
          icon: 'zmdi-laptop',
          visible: ['windows'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.agent_uninstall_password'),
          # data: device&.device_passcode || I18n.t('common.na'),
          icon: 'zmdi-key',
          visible: ['macos', 'windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('emm_ios.dep.info.server'),
        data: device&.dep_device&.account&.server_name || I18n.t('common.na'),
        icon: 'zmdi-storage zmdi-hc-flip-horizontal',
        visible: ['ios', 'macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('common.shared_ipad'),
        data: device.shared_ipad? ? I18n.t('common.text_yes') : I18n.t('common.text_no'),
        icon: 'zmdi-tablet-mac',
        visible: device.ipad?
      },
      {
        title: I18n.t('full_device_info.per_user_storage'),
        data: device.shared_ipad? && "#{device.quota_size} MB" || I18n.t('common.na'),
        icon: 'zmdi-storage',
        visible: device.shared_ipad?
      },
      {
        title: I18n.t('full_device_info.estimated_users'),
        data: device.shared_ipad? && device.estimated_users  || I18n.t('common.na'),
        icon: 'zmdi-accounts-alt',
        visible: device.shared_ipad?
      }
    ]
    
  end

  def full_device_info(device)
    device_info = [
      {
        title: device&.os_type == 'windows' ? I18n.t('windows.manufacturer') : I18n.t('full_device_info.make'),
        data: device&.make || I18n.t('common.na'),
        icon: 'zmdi-desktop-mac',
        visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.model'),
        data: device&.model || I18n.t('common.na'),
        icon: 'zmdi-smartphone',
        visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.os_version'),
        data: device&.os_version || I18n.t('common.na'),
        icon: os_zmdi_icon,
        visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.model_name'),
        data: device&.device_model_name || I18n.t('common.na'),
        icon: 'zmdi-smartphone-info',
        visible: ['ios', 'macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.os_version_name'),
        data: os_platform_value(device) || I18n.t('common.na'),
        icon: 'zmdi zmdi-laptop',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('windows.machine_name'),
        data: device&.machine_name || I18n.t('common.na'),
        icon: 'zmdi-devices',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.screen_resolution'),
        data: screen_resolution,
        icon: 'zmdi-fullscreen-alt',
        visible: ['android', 'windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.imei_no'),
        data: get_imei_number,
        icon: 'zmdi-memory',
        visible: ['android', 'ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.imsi_no'),
        data: get_imsi_number,
        icon: 'zmdi-memory',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.iccid_no'),
        data: get_iccid_number,
        icon: 'zmdi-memory',
        visible: ['android', 'ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.phone_no'),
        data: get_phone_number,
        icon: 'zmdi-smartphone',
        visible: ['android', 'ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.serial_no'),
        data: serial_number,
        icon: 'zmdi-format-list-numbered',
        visible: ['android', 'ios', 'macos', 'windows'].include?(device.os.downcase)
      },
      {
        key: "host_name",
        title: I18n.t('full_device_info.host_name'),
        icon: 'zmdi-desktop-windows',
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('windows.antispyware_status'),
        data: device&.os.downcase == 'windows' ? device&.antispyware : I18n.t('common.na'),
        icon: 'zmdi-shield-security',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('windows.antivirus_status'),
        data: device&.os.downcase == 'windows' ? device&.antivirus : I18n.t('common.na'),
        icon: 'zmdi-shield-check',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.safe_mode.device_encrypted'),
        data: safe_mode_device_encrypted,
        icon: 'zmdi-smartphone-lock',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.safe_mode.passcode'),
        data: safe_mode_info,
        icon: 'zmdi-shield-security',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.firmware_bios'),
        data: device&.device_firmware || I18n.t('common.na'),
        icon: 'zmdi-smartphone-lock',
        visible: visible_info_device_info?
      },
      {
        title: I18n.t('devices.build_version'),
        data: device&.device_firmware || I18n.t('common.na'),
        icon: 'zmdi-smartphone-lock',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('windows.firewall_status'),
        data: device.try(:firewall) || I18n.t('common.na'),
        icon: 'zmdi-view-quilt',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.itune_account_active'),
        data: (device.try(:itunes_store_account_active) ? I18n.t('common.configured') : I18n.t('common.not_configured')) || I18n.t('common.na'),
        icon: 'zmdi-apple',
        visible: ['ios', 'macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.itune_account_id'),
        data: device&.macos? && device&.enrolled_user_info&.apple_id || I18n.t('common.na'),
        icon: 'zmdi-apple',
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.dnd_activated'),
        data: (device&.dnd_on == true ? I18n.t('common.enabled') : I18n.t('common.disabled')) || I18n.t('common.na'),
        icon: 'zmdi-minus-circle',
        visible: ['ios', 'macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.hotspot_enabled'),
        data: (device&.hotspot_enabled == true ? I18n.t('common.enabled') : I18n.t('common.disabled'))|| I18n.t('common.na'),
        icon: 'zmdi-apple',
        visible: ['ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.lost_mode_activated'),
        data: (device&.lost_mode_applied == true ? I18n.t('common.enabled') : I18n.t('common.disabled')) || I18n.t('common.na'),
        icon: 'zmdi-search',
        visible: ['ios', 'windows', 'android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.find_phone_activated'),
        data: (device&.activated == true ? I18n.t('common.enabled') : I18n.t('common.disabled')) || I18n.t('common.na'),
        icon: 'zmdi-search',
        visible: ['ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.supervised'),
        data: (device.try(:is_supervised) ? I18n.t('common.enabled') : I18n.t('common.disabled')) || I18n.t('common.na'),
        icon: 'zmdi-eye',
        visible: ['ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.passcode_compliant'),
        data: (device&.os_type == 'ios' && device&.passcode_compliant_with_profiles ? I18n.t('common.enabled') : I18n.t('common.disabled'))|| I18n.t('common.na'),
        icon: 'zmdi-smartphone-lock',
        visible: ['ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.data_usage'),
        data: device.monthly_data_usage > 0 ? number_to_human_size(@device.monthly_data_usage) : I18n.t('common.not_available'),
        icon: 'zmdi-chart',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('common.timezone'),
        data: device&.timezone || I18n.t('common.na'),
        icon: 'zmdi zmdi-time',
        visible: ['android', 'windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.play_protect_compliance'),
        data: device.safety_net_api_log&.safety_net_api_data&.present? ? (device.safety_net_api_log&.safety_net_api_data["error"]&.present? ? I18n.t('common.text_no') : I18n.t('common.text_yes')) : I18n.t('common.na'),
        icon: 'zmdi-shield-security',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.system_integrity'),
        data: (device.macos? && device&.enabled_system_integrity_protection == true ? I18n.t('common.text_yes') : I18n.t('common.text_no')) || I18n.t('common.na'),
        icon: 'zmdi-laptop',
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('windows.domain_name'),
        data: device.try(:domain_name) || I18n.t('common.na'),
        icon: 'zmdi-globe-alt',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.bitlocker_status'),
        data: (device&.windows? && device.os_drive_encrypted?) ? I18n.t("devices.encrypted") : I18n.t("devices.not_encrypted"),
        icon: 'zmdi-key',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.rooted'),
        data: t("common.#{rooted_str(device)}") || I18n.t('common.na'),
        icon: 'zmdi-smartphone',
        visible: ['android', 'windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.jailbroken'),
        data: rooted_str(device)  || I18n.t('common.na') ,
        icon: 'zmdi-smartphone',
        visible: ['ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.mx_version'),
        data: (device&.make == "Zebra Technologies" ? device&.mx_version : '') || I18n.t('common.na'),
        icon: 'zmdi-android',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.udid'),
        data: device&.device_unique_id || I18n.t('common.na'),
        icon: 'zmdi-smartphone',
        visible: ['ios','macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.battery'),
        data: battery_status(device),
        icon: device&.charging ? 'zmdi-battery-charging' : 'zmdi-battery',
        visible: ['android', 'ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.battery_saver_activated'),
        data: (device&.battery_saver_activated == true ? I18n.t('common.text_yes') : I18n.t('common.text_no')) || I18n.t('common.na'),
        icon: 'zmdi-battery-flash',
        visible: ['android', 'windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.battery_health'),
        data: device&.battery_health_status || I18n.t('common.na'),
        icon: 'zmdi-battery-flash',
        visible: show_battery_health?
      },
      {
        title: I18n.t('devices.battery_temp'),
        data: battery_temp,
        icon: 'zmdi-battery-flash',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.cpu_usage'),
        data: device&.cpu_usage.present? ? (device&.cpu_usage.to_s+'%') : I18n.t('common.na'),
        icon: 'zmdi-memory',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.cpu_temp'),
        data: cpu_temp,
        icon: 'zmdi-memory',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.cpu_usage'),
        data: cpu_usage_data,
        icon: 'zmdi-memory',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.ram_usage'),
        data: ram_usage_data,
        icon: 'zmdi-memory',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.ram_usage'),
        data: ram_usage,
        icon: 'zmdi-settings-square',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.screen_temp'),
        data: screen_temp,
        icon: 'zmdi-fullscreen',
        visible: ['android'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.tpm_chip_version'),
        data: tpm_chip_version,
        icon: 'zmdi-view-quilt',
        visible: visible_info_device_info?
      },
      {
        title: I18n.t('devices.processor'),
        data: processor_details,
        icon: 'zmdi-view-quilt',
        visible: visible_info_device_info?
      },
      {
        title: I18n.t('devices.bios_details'),
        data: bios_details,
        icon: 'zmdi-view-quilt',
        visible: visible_info_device_info?
      },
      {
        title: I18n.t('devices.intel_vpro'),
        data: '',
        icon: 'zmdi-view-quilt',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.power_status'),
        data: power_state(@device.try(:power_status), @device.charging) || I18n.t('common.na'),
        icon: 'zmdi-battery-flash',
        visible: ['android', 'windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('common.esim_identifier'),
        data: device.try(:eid) || I18n.t('common.na'),
        icon: 'zmdi-card-sim',
        visible: ['ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.bios_mebx_password'),
        data: bios_mebx_password,
        icon: 'zmdi-smartphone-lock',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: 'Type',
        # data: device&.system ? device&.system.type : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'Baseboard Type',
        # data: device&.baseboard ? device&.baseboard.type : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'Baseboard Manufacturer',
        # data: device&.baseboard ? device&.baseboard.manufacturer : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'Baseboard Product Name',
        # data: device&.baseboard ? device&.baseboard.product_name : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'Baseboard Serial Number',
        # data: device&.baseboard ? device&.baseboard.serial_number : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'Bios Vendor',
        # data: device&.bios ? device&.bios.vendor : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'Bios Release Date',
        # data: device&.bios ? device&.bios.release_date : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'Battery Name',
        # data: device&.battery ? device&.battery.name : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'Battery Manufactured On',
        # data: device&.battery ? device&.battery.manufacture_date : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'Battery Capacity',
        # data: device&.battery ? device&.battery.capacity : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'Battery Voltage',
        # data: device&.battery ? device&.battery.voltage : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'Battery Type',
        # data: device&.battery ? device&.battery.type : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'CPU Model',
        # data: device&.cpu ? device&.cpu.cpu_model_name : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'CPU Vendor',
        # data: device&.cpu ? device&.cpu.vendor : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'CPU Architecture',
        # data: device&.cpu ? device&.cpu.architecture : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'CPU Total Cores',
        # data: device&.cpu ? device&.cpu.total_cores : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'RAM Max Capacity',
        # data: device&.memory ? device&.memory.max_capacity : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: 'RAM Slots',
        # data: device&.memory ? device&.memory.slots : 'N/A',
        icon: 'zmdi-smartphone-lock',
        visible: ['nix'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.bootstrap_token_available'),
        data: apple_device_detail&.bootstrap_token&.present? ? I18n.t('common.text_yes') : I18n.t('common.text_no'),
        icon: 'zmdi-key',
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.apple_silicon'),
        data: device.try(:apple_silicon) ? I18n.t('common.text_yes') : I18n.t('common.text_no'),
        icon: 'zmdi-apple',
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.bypass_code'),
        data: (device.try(:device_bypass_code) || device.try(:mdm_bypass_code)) ? "Available" : 'N/A',
        icon: 'zmdi-globe-lock',
        visible: ['ios', 'macos'].include?(device.os.downcase) && !device&.shared_ipad?
      },
      {
        title: t('full_device_info.power_on_time'),
        data: @device&.last_power_on_time ? @device&.last_power_on_time&.strftime('%d-%b-%Y %I:%M %p') : t('common.na'),
        icon: 'zmdi-power',
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: t('full_device_info.power_off_time'),
        data: @device&.last_power_off_time ? @device&.last_power_off_time&.strftime('%d-%b-%Y %I:%M %p') : t('common.na'),
        icon: 'zmdi-power-off',
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: t('devices.uptime'),
        data: (distance_of_time_in_words(@device.last_power_off_time, Time.current) if @device.last_power_off_time) || t('common.na'),
        svg_icon: asset_path("common-assets/ic-uptime.svg"),
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: t('full_device_info.attestation_status'),
        data: device.attestation_status || t('common.na'),
        icon: 'zmdi-shield-security',
        visible: ['macos', 'ios', 'android'].include?(device.os.downcase) # ipad also included with ios os type
      },
      {
        title: t('full_device_info.app_preservation_status'),
        data: t("full_device_info.app_preservation_state.#{device.try(:app_preservation_state)}"),
        icon: 'zmdi-time-restore-setting',
        visible: device.ios? # ipad also included with ios os type
      }
    ]

    # Filter the device info array based on the 'visible' key being true
    filtered_device_info = device_info.select { |info| info[:visible] }

    filtered_device_info.each do |info|
      next if info[:data].present? 
      
      if info[:key].present?
        info[:data] = device&.send(info[:key]) || I18n.t('common.na') 
      end
    end

    filtered_device_info     
  end

  def security_posture
    device_posture = device&.amapi_device_property&.device_posture || 'No Risk';
    security_risk = device&.amapi_device_property&.security_risk || 'No Risk';

    if device.android?
      "<strong>Device Posture</strong>: #{device_posture}<br/><strong>Security Risk</strong>: #{security_risk}"
    else
      I18n.t('common.na')
    end
  end

  def user_enrolled_device_info(device)
    [
      {
          title: device&.os_type == 'windows' ? I18n.t('windows.manufacturer') : I18n.t('full_device_info.make'),
          data: device&.make || I18n.t('common.na'),
          icon: 'zmdi-desktop-mac',
          visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.model'),
          data: device&.model || I18n.t('common.na'),
          icon: 'zmdi-smartphone',
          visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.os_version'),
          data: device&.os_version || I18n.t('common.na'),
          icon: os_zmdi_icon,
          visible: ['android', 'ios', 'macos', 'windows', 'nix'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.product_model_name'),
          data: device&.device_model_name || I18n.t('common.na'),
          icon: 'zmdi-smartphone-info',
          visible: ['ios', 'macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.phone_no'),
          data: get_phone_number,
          icon: 'zmdi-smartphone',
          visible: ['android', 'ios'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.supervised'),
          data: (@device.ios? && device&.is_supervised == true ? I18n.t('common.enabled') : I18n.t('common.disabled')) || I18n.t('common.na'),
          icon: 'zmdi-eye',
          visible: ['ios'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.passcode_compliant'),
          data: (@device.ios?  && @device.passcode_compliant_with_profiles == true ? I18n.t('common.enabled') : I18n.t('common.disabled'))|| I18n.t('common.na'),
          icon: 'zmdi-smartphone-lock',
          visible: ['ios'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.jailbroken'),
          data: t("common.#{device&.rooted}") || I18n.t('common.na') ,
          icon: 'zmdi-smartphone',
          visible: ['ios'].include?(device.os.downcase)
      },
      {
          title: I18n.t('full_device_info.udid'),
          data: device&.device_unique_id || I18n.t('common.na'),
          icon: 'zmdi-smartphone',
          visible: ['ios','macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.battery'),
          data: battery_status(device),
          icon: device&.charging ? 'zmdi-battery-charging' : 'zmdi-battery',
          visible: ['android', 'ios'].include?(device.os.downcase)
      },
      {
        title: t('full_device_info.attestation_status'),
        data: device.attestation_status || t('common.na'),
        icon: 'zmdi-shield-security',
        visible: ['macos', 'ios', 'android'].include?(device.os.downcase) # ipad also included with ios os type
      },
      {
        title: t('full_device_info.app_preservation_status'),
        data: t("full_device_info.app_preservation_state.#{device.app_preservation_state}"),
        icon: 'zmdi-time-restore-setting',
        visible: device.ios? # ipad also included with ios os type
      }
    ]
  end

  def device_network_info(device)
    [
      {
        title: t("windows.connection_status"),
        data: connection_status(device) || t("common.na"),
        icon: "zmdi-network",
        visible: ["android", "windows"].include?(device.os.downcase)
      },
      {
        title: t("devices.ip_address"),
        data: device&.ip_address || t("common.na"),
        icon: "zmdi-pin",
        visible: ["android", "ios", "macos", "windows"].include?(device.os.downcase)
      },
      {
        title: t("devices.ethernet_mac"),
        data: device&.ethernet_mac || t("common.na"),
        icon: "zmdi-router",
        visible: ["macos", "windows"].include?(device.os.downcase)
      },
      {
        title: t("devices.bluetooth_mac"),
        data: device&.bluetooth_mac || t("common.na"),
        icon: "zmdi-bluetooth-search",
        visible: ["android", "ios", "macos", "windows"].include?(device.os.downcase)
      },
      {
        title: t("devices.wifi_mac"),
        data: wifi_data,
        icon: "zmdi-portable-wifi",
        visible: ["android", "ios", "macos", "windows"].include?(device.os.downcase)
      },
      {
        title: t("devices.wifi_frequency_band"),
        data: wifi_frequency_band || t("common.na"),
        icon: "zmdi-portable-wifi-changes",
        visible: ["android"].include?(device.os.downcase)
      },
      {
        title: t("devices.wifi_signal_strength"),
        data: wifi_strength || t("common.na"),
        icon: "zmdi-wifi-alt",
        visible: ["android", "windows"].include?(device.os.downcase)
      },
      {
        title: t("devices.connected_wifi"),
        data: wifi_ssid || t("common.na"),
        icon: "zmdi-wifi-info",
        visible: ["android", "windows"].include?(device.os.downcase)
      },
      {
        title: t("devices.nearby_wifi"),
        icon: "zmdi-input-antenna",
        visible: ["android"].include?(device.os.downcase)
      },
      {
        title: t("full_device_info.connected_sim"),
        data: device&.connected_sim || t("common.na"),
        icon: "zmdi-card-sim",
        visible: ["android"].include?(device.os.downcase),
        slug: "connected_sim",
      },
      {
        title: t("full_device_info.sim_card_available"),
        data: sim_card_available || t("common.na"),
        icon: "zmdi-card-sim",
        visible: ["android"].include?(device.os.downcase)
      },
      {
        title: t("full_device_info.current_carrier_network"),
        data: current_carrier_network || t("common.na"),
        icon: "zmdi-network",
        visible: ["ios"].include?(device.os.downcase)
      },
      {
        title: t("full_device_info.network_operator"),
        data: network_operator || t("common.na"),
        icon: "zmdi-network",
        visible: ["android", "ios"].include?(device.os.downcase)
      },
      {
        title: t("full_device_info.signal_strength"),
        data: signal_strength || t("common.na"),
        icon: "zmdi-network-outline",
        visible: ["android"].include?(device.os.downcase)
      },
      {
        title: t("full_device_info.data_roaming_status"),
        data: data_roaming_status || t("common.na"),
        icon: "zmdi-swap-vertical",
        visible: ["android", "ios"].include?(device.os.downcase)
      },
      {
        title: t("full_device_info.voice_roaming_status"),
        data: voice_roaming_status || t("common.na"),
        icon: "zmdi-surround-sound",
        visible: ["android", "ios"].include?(device.os.downcase)
      },
      {
        title: t("full_device_info.roaming_status"),
        data: get_roaming_status,
        icon: "zmdi-swap-vertical",
        visible: ["ios"].include?(device.os.downcase)
      },
      {
        title: t("full_device_info.meid"),
        data: @device&.ios? && get_meid || t("common.na"),
        icon: "zmdi-network",
        visible: ["ios"].include?(device.os.downcase)
      },
      {
        title: t("devices.public_ip"),
        data: device&.public_ip || t("common.na"),
        icon: "zmdi-pin",
        visible: ["android", "ios", "macos", "windows"].include?(device.os.downcase)
      },
      {
        title: t("full_device_info.subnet_mask"),
        data: device&.windows? && device&.subnet_mask.present? ? device&.subnet_mask : t("common.na"),
        icon: "zmdi-network",
        visible: ["windows"].include?(device.os.downcase),
      },
    ]
  end

  def full_device_info_tabs
    tabs = [t("full_device_info.management_info")]
    tabs << t("full_device_info.device_info")
    tabs << t("full_device_info.hardware_info") if device.windows?
    tabs << t("full_device_info.network_info")
    tabs << t("full_device_info.sim_binding") if device.os.downcase == 'android' && device.mode != 'byod'
    tabs << t("full_device_info.storage_info")
    tabs << t("full_device_info.filevault_info") if device.os.downcase == 'macos'
    tabs << t("full_device_info.startup_security") if device.os.downcase == 'macos'
    tabs << t("full_device_info.os_update_info") if device&.macos? || (device&.android? && device.os_update_supported?)
    tabs << t("full_device_info.user_info") if device.os.downcase == 'macos' || device.os.downcase == 'windows' || @device&.shared_ipad?
    tabs << t("full_device_info.peripheral_statistics") if device.os.downcase == 'windows'
    tabs << t("full_device_info.compliance.compliance") if (device.compliance_policy_group.present? && (['macos', 'android', 'ios', 'windows'].include?(device.os.downcase)))
    tabs << t("full_device_info.custom_properties")
    tabs
  end

  def os_platform_value(device)
    if device&.windows?
      device&.os_platform
    elsif device.nix?
      device.os_info&.codename
    else
      device.os_version
    end
  end

  def enrollment_mode
    mode =  device.os_type == "android" ? (device&.device_profile&.mode || device[:mode] ) : device[:mode]
    if mode == 'kiosk' || mode.nil?
      'Kiosk'
    elsif cope_device?(device)
      'WPCO/COPE'
    elsif apple_user_enrolled_device?(device)
      'User'
    elsif mode == 'byod'
      'BYOD'
    else
      I18n.t('common.na') # Assuming $tt in JavaScript maps to I18n.t in Ruby
    end
  end
  
  def cope_device?(device)
    device[:os_type] == 'android' && device[:mode] == 'byod' && device[:cope_enabled]
  end
  
  def apple_user_enrolled_device?(device)
    device[:os_type] == 'ios' && device[:mode] == 'user_enrolled'
  end

  def enrollment_email
    return device.enrollment_user_email unless device.os_type == 'windows'
    device.enrollment_user_email || device.windows_device_detail&.onboarding_email
  end
  
  def notification_permission
    if %w[ios macos].include?(device[:os_type]) && device[:app_version_name]
      notification_permission = !!device.permissions_status&.find{|permission| permission["name"]== "notification"}&.dig("status")
      I18n.t("common.text_#{notification_permission}")
    else
      I18n.t('common.na')
    end
  end

  def location_permission
    if %w[ios macos].include?(device[:os_type]) && device[:app_version_name]
      location_permission = !!device.permissions_status&.find{|permission| permission["name"]== "location"}&.dig("status")
      I18n.t("common.text_#{location_permission}")
    else
      I18n.t('common.na')
    end
  end
  
  def date_custom_format(date)
    # date.strftime("%-d %b %Y, %-I:%M %p")
    in_users_timezone(date)
  end

  def user_info_items(device)
    [
      {
        title: I18n.t('full_device_info.current_logged_in_user'),
        data: @device&.ios? ? @device.ipad_user_accounts.find_by(logged_in: true)&.username : @device&.current_logged_in_user || I18n.t('common.na'),
        icon: 'zmdi-account-circle',
        visible: ['windows', 'macos', 'ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.current_user_login_time'),
        data: device&.current_user_login_time&.present? ? (@device.ios? ? in_users_timezone(@device.signed_in_at) : in_users_timezone(device&.current_user_login_time)) : I18n.t('common.na'),
        icon: 'zmdi-time',
        visible: ['windows', 'macos', 'ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.last_logged_in_user'),
        data: device&.ios? ? @device.device_user_login_statistics.last_logged_in.first&.organization_user_email : device&.last_logged_in_user || I18n.t('common.na'),
        icon: 'zmdi-account-circle',
        visible: ['windows', 'macos', 'ios'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.last_user_logoff_time'),
        data: device&.last_user_logoff_time.present? ? in_users_timezone(device&.last_user_logoff_time) : I18n.t('common.na'),
        icon: 'zmdi-time',
        visible: ['windows', 'macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.last_reboot_time'),
        data: windows_last_reboot_time,
        icon: 'zmdi-time',
        visible: ['windows'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.enrolled_user'),
        data: get_enrolled_user_info,
        icon: 'zmdi-account-circle',
        visible: ['windows', 'macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('common.ade_admin'),
        icon: 'zmdi-account-circle',
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('common.global_admin'),
        icon: 'zmdi-account-circle',
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('full_device_info.admin_account'),
        icon: "zmdi-account-circle",
        visible: ['windows'].include?(device.os.downcase)
      }
    ]
  end

  def windows_last_reboot_time
    device.os.downcase == 'windows' && in_users_timezone(device&.last_reboot_time) || I18n.t('common.na')
  end

  def file_vault_info_items(device)
    [
      {
          title: I18n.t('devices.file_vault.fde_status'),
          data: (device&.encrypted? ? I18n.t('common.enabled') : I18n.t('common.disabled')) || I18n.t('common.na'),
          icon: 'zmdi-dns',
          visible: ['macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.file_vault.fde_key_type'),
          data: device_fde_key_type_device(device) || I18n.t('common.na'),
          icon: 'zmdi-key',
          visible: ['macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.file_vault.fde_irk'),
          # data: device_fde_irk(device),
          icon: 'zmdi-balance',
          visible: ['macos'].include?(device.os.downcase)
      },
      # {
      #     title: I18n.t('devices.file_vault.fde_prk'),
      #     icon: 'zmdi-key',
      #     visible: ['macos'].include?(device.os.downcase)
      # },
      {
        title: I18n.t('devices.file_vault.validation_status'),
        data: device.mac_file_vault_recovery_key_valid,
        icon: 'zmdi-shield-check',
        visible: ['macos'].include?(device.os.downcase)
      }
    ]
  end

  def os_update_info_item(device)
    [
      {
          title: I18n.t('devices.catalog_url'),
          data: device&.catalog_url || I18n.t('common.na'),
          icon: 'zmdi-http',
          visible: ['macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.last_scan_date'),
          data: device&.previous_scan_date || I18n.t('common.na'),
          icon: 'zmdi-time',
          visible: ['macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.periodic_update_check'),
          data: device&.perform_periodic_check || I18n.t('common.na'),
          icon: 'zmdi-assignment-check',
          visible: ['macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.auto_check'),
          data: (device&.auto_check_enabled == true ? I18n.t('common.enabled') : I18n.t('common.disabled')) || I18n.t('common.na'),
          icon: 'zmdi-rotate-left',
          visible: ['macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.background_download'),
          data: (device&.background_download_enabled == true ? I18n.t('common.enabled') : I18n.t('common.disabled')) || I18n.t('common.na'),
          icon: 'zmdi-download',
          visible: ['macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.auto_app_installation'),
          data: device&.auto_app_installation_enable || I18n.t('common.na'),
          icon: 'zmdi-apps',
          visible: ['macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.auto_os_installation'),
          data: device&.auto_os_installation_enable || I18n.t('common.na'),
          icon: 'zmdi-remote-control',
          visible: ['macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.auto_security_updates'),
          data: (device&.security_update_enable == true ? I18n.t('common.enabled') : I18n.t('common.disabled')) || I18n.t('common.na'),
          icon: 'zmdi-shield-check',
          visible: ['macos'].include?(device.os.downcase)
      },
      {
          title: I18n.t('devices.os_updates.enforced_os_update'),
          data: @enforced_apple_os_update.present? ? I18n.t('devices.os_updates.enforced_os_update_state', os_version: @enforced_apple_os_update&.os_update&.version, time: @enforced_apple_os_update.enforced_at&.in_time_zone(device&.timezone&.presence || current_user.preferred_timezone)&.strftime('%d-%b-%Y %I:%M %p')) : I18n.t('common.na'),
          icon: 'zmdi-smartphone',
          visible: ['macos'].include?(device.os.downcase)
      }
    ]
  end

  def compliance_items(device)
    [
      {
        title: t('full_device_info.compliance.policy_group'),
        data: device&.compliance_policy_group.name,
        slug: 'compliance',
        icon: asset_path("v2/icons/compliance_policy_groups/policy-group.svg")
      },
      {
        title: I18n.t('full_device_info.compliance.benchmark'),
        data: helpers.get_device_benchmark_name(device),
        slug: 'compliance',
        icon: asset_path("v2/icons/compliance_policy_groups/benchmark-name.svg")
      },
      {
        title: I18n.t('full_device_info.compliance.variant'),
        data: device&.applicable_benchmark&.name || I18n.t('common.na'),
        slug: 'compliance',
        icon: asset_path("v2/icons/compliance_policy_groups/benchmark-type.svg")
      },
      {
        title: I18n.t('full_device_info.compliance.mode'),
        data: helpers.policy_filter_benchmark_types&.key(@device&.compliance_policy_group&.benchmark_type),
        slug: 'compliance',
        icon: device&.compliance_policy_group.monitoring? ? asset_path("v2/icons/compliance_policy_groups/monitor-only.svg") : asset_path("v2/icons/compliance_policy_groups/monitor-remediate.svg")
      },
      {
        title: I18n.t('full_device_info.compliance.status'),
        data: device&.compliance_status,
        slug: 'compliance',
        icon: asset_path("v2/icons/compliance_policy_groups/compliance-status.svg")
      },
      {
        title: I18n.t('full_device_info.compliance.percentage'),
        data: device&.device_compliance_benchmark_mapping&.compliance_percentage.present? ? "#{device&.device_compliance_benchmark_mapping&.compliance_percentage.floor} %" : t('common.na'),
        slug: 'compliance',
        icon: asset_path("v2/icons/compliance_policy_groups/compliance-percentage.svg")
      },
      {
        title: I18n.t('full_device_info.compliance.risk'),
        data: device&.device_compliance_benchmark_mapping&.risk_status,
        slug: 'compliance',
        icon: asset_path("v2/icons/compliance_policy_groups/risk-status.svg")
      }
    ]
  end

  def device_fde_key_type_device(d)
    (d&.fde_has_institutional_recovery_key && d.fde_has_personal_recovery_key ? 'Institutional & Personal' : (d&.fde_has_institutional_recovery_key ? 'Institutional' : (d&.fde_has_personal_recovery_key ? 'Personal' : 'N/A')))
  end

  def device_fde_irk(device)
    device&.macos? && (device&.fde_has_institutional_recovery_key && device.fde_certificate ? true : false)
  end
  
  def startup_security_info_items(device)
    status = device.device_lock_status&.status
    [
      {
        title: I18n.t('devices.startup_security.type'),
        data: device&.apple_device_detail&.apple_silicon? ? I18n.t("recovery_firmware_management.recovery_lock") : I18n.t("recovery_firmware_management.firmware_password"),
        icon: asset_path("v2/icons/startup_security/type.svg"),
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.startup_security.enabled'),
        data: device&.device_lock_status&.enabled ? I18n.t("common.text_yes") : I18n.t("common.text_no"),
        icon: asset_path("v2/icons/startup_security/enabled.svg"),
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.startup_security.password'),
        data: device&.device_lock_infos&.length > 0,
        icon: asset_path("v2/icons/startup_security/password.svg"),
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.startup_security.password_status'),
        data: status.present? ? I18n.t("recovery_firmware_management.lock_status.status.#{device.device_lock_status&.status}") : I18n.t("common.na"),
        icon: asset_path("v2/icons/startup_security/password-status.svg"),
        visible: ['macos'].include?(device.os.downcase)
      },
      {
        title: I18n.t('devices.startup_security.change_pending'),
        data: device&.device_lock_status&.firmware_password_change_pending ? I18n.t("common.text_yes") : I18n.t("common.text_no"),
        icon: asset_path("v2/icons/startup_security/security-change-pending.svg"),
        visible: ['macos'].include?(device.os.downcase) && !device&.apple_device_detail&.apple_silicon?
      },
      {
        title: I18n.t('devices.startup_security.orom_allowed'),
        data: device&.device_lock_status&.firmware_allow_oroms ? I18n.t("common.text_yes") : I18n.t("common.text_no"),
        icon: asset_path("v2/icons/startup_security/orom.svg"),
        visible: ['macos'].include?(device.os.downcase) && !device&.apple_device_detail&.apple_silicon?
      }
    ]
  end
  
  def apple_device_detail
    @apple_device_detail ||= device.apple_device_detail
  end
end
  