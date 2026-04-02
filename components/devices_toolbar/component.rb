# frozen_string_literal: true

class DevicesToolbar::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  include ApplicationHelper
  attr_reader :current_user
  option :current_user, default: proc { nil }

  def view_filter_options
      [
        [I18n.t("devices.all_devices"), "all"],
        [I18n.t("v2.filters.android_devices"), "android_devices"],
        [I18n.t("v2.filters.ios_devices"), "ios_devices"],
        [I18n.t("v2.filters.macos_devices"), "macos_devices"],
        [I18n.t("v2.filters.tvos_devices"), "tvos_devices"],
        [I18n.t("v2.filters.windows_devices"), "windows_devices"],
        [I18n.t("v2.filters.nix_devices"), "nix_devices"],
        [I18n.t("v2.filters.chrome_os_devices"), "chrome_os_devices"],
        [I18n.t("v2.filters.printer_devices"), "printer_devices"],
        [I18n.t("v2.filters.locked"), "locked"],
        [I18n.t("v2.filters.unlocked"), "unlocked"],
        [I18n.t("v2.filters.inactive"), "inactive"],
        [I18n.t("v2.filters.unlicensed"), "unlicensed"],
        [I18n.t("v2.filters.factory_reset"), "factory_reset"],
        [I18n.t("v2.filters.chromeos_deprovisioned"), "deprovisioned"],
        [I18n.t("v2.filters.low_battery"), "low_battery"],
        [I18n.t("v2.filters.recently_added"), "recently_added"],
        [I18n.t("v2.filters.waiting_for_activation"), "waiting_for_activation"]
      ]
  end 

  def emm_filters
    [
      [I18n.t("v2.filters.all"), "all"],
      [I18n.t("v2.filters.emm_devices"), true],
      [I18n.t("v2.filters.non_emm_devices"), false],
    ]
  end

  def devices_reset_filter_params(current_user, params)
    _params = {
      compact: true,
      count: 100,
      only_android: false,
      only_byod: false,
      orphans: false,
      orphans_ios: false,
      orphans_mac: false,
      orphans_nix: false,
      orphans_windows: false,
      page: 1,
      skip_amapi: false,
      skip_byod: false,
      skip_macos: false,
      ungrouped: false,
      unscoped: true,
      reset: true
    }
    user_devices_path(current_user, _params)
  end

  def deep_dive_filter(deep_dive_filter, tab)
    JSON.parse(deep_dive_filter)["#{tab}"]
  end

  def replace_string(deep_dive_filter, tab)
    deep_dive_filter(deep_dive_filter, tab).gsub(/[_-]/, " ").upcase
  end
end
  