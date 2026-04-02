# frozen_string_literal: true

class OemLogos::Component < ApplicationViewComponent
  renders_one :custom_label
  LOGO_PATHS = {
    android_enterprise: 'v2/icons/secure_settings_logos/afw-logo@2x.png',
    samsung_knox: 'v2/icons/secure_settings_logos/samsung-knox@2x.png',
    lg_gate: 'v2/icons/secure_settings_logos/lg-gate@2x.png',
    lenovo: 'v2/icons/secure_settings_logos/lenovo@2x.png',
    sony: 'v2/icons/secure_settings_logos/sony@2x.png',
    wingman: 'v2/icons/secure_settings_logos/wingman@2x.png',
    huawei: 'v2/icons/secure_settings_logos/huawei.svg',
    zebra: 'v2/icons/ic-zebra-small.png'
  }.freeze

  SETTINGS_LOGOS = {
    power_off_device: %i[samsung_knox lg_gate lenovo sony huawei],
    airplane_mode: %i[samsung_knox lg_gate wingman],
    unknown_sources: %i[android_enterprise samsung_knox lg_gate],
    uninstall_clear_app_data: %i[android_enterprise],
    firmware_recovery_samsung: %i[samsung_knox],
    allow_home_key: %i[samsung_knox lg_gate lenovo sony wingman huawei],
    allow_back_key: %i[samsung_knox lg_gate lenovo sony wingman huawei],
    allow_switch_key: %i[samsung_knox lg_gate lenovo sony wingman huawei],
    quick_settings: %i[samsung_knox lg_gate],
    allow_mtp_access: %i[samsung_knox lg_gate lenovo huawei],
    allow_device_via_usb_access: %i[android_enterprise samsung_knox lg_gate sony huawei],
    additional_setting: %i[lenovo],
    system_update_policy_setting: %i[android_enterprise],
    allow_ota_upgrade: %i[samsung_knox lenovo huawei],
    disallow_set_wallpaper: %i[android_enterprise samsung_knox],
    volume_key: %i[lenovo samsung_knox],
    schedule_power_on_off: %i[lenovo samsung_knox wingman zebra],
    enable_location: %i[android_enterprise wingman lenovo],
    samsung_knox: %i[samsung_knox],
    language_access: %i[wingman samsung_knox],
    allow_flight_mode: %i[samsung_knox lenovo wingman],
    mobile_data_state: %i[lenovo samsung_knox wingman],
    data_roaming_state: %i[android_enterprise samsung_knox],
    prevent_inapp_browsing: %i[android_enterprise],
    block_emergency_component: %i[lenovo],
    gps_always_off: %i[android_enterprise wingman samsung_knox lenovo],
    change_data_or_time_setting: %i[android_enterprise samsung_knox],
    timezone: %i[android_enterprise lenovo samsung_knox],
    set_date_or_time: %i[android_enterprise lenovo samsung_knox],
    set_lock_screen_to_none: %i[wingman],
    double_tap_to_wake: %i[wingman],
    system_error_and_floating_window: %i[android_enterprise],
    configure_device_blocking_settings: %i[android_enterprise],
    shutdown_device: %i[samsung_knox lenovo wingman zebra],
    allow_lock_screen_control_center: %i[lenovo],
    settings_on_boot_blocked: %i[android_enterprise],
    uninstallation_settings: %i[android_enterprise],
    enable_lift_to_wake: %i[wingman],
    configure_application_blocklist: %i[android_enterprise samsung_knox lenovo huawei wingman],
    blocklist_component_name: %i[samsung_knox lenovo wingman],
    data_usage_settings: %i[android_enterprise],
    sd_card_usage_enabled: %i[samsung_knox lenovo],
    disable_sim: %i[lenovo],
    disable_accessibility: %i[lenovo],
    battery_percentage_in_status_bar: %i[wingman zebra],
    configure_navigation_mode: %i[wingman zebra],
    show_airplane_mode: %i[android_enterprise samsung_knox lg_gate huawei],
    block_incoming_calls: %i[android_enterprise samsung_knox],
    wipe_sd_card: %i[samsung_knox]
  }.freeze

  DEFAULT_LOGOS = %i[android_enterprise samsung_knox lg_gate lenovo sony wingman huawei zebra].freeze

  def initialize(setting:)
    @setting = setting.to_sym
  end

  def logos
    logo_keys = SETTINGS_LOGOS.fetch(@setting, DEFAULT_LOGOS)
    logo_keys.map { |logo_key| LOGO_PATHS[logo_key] }
  end
end
  