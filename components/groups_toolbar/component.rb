# frozen_string_literal: true

class GroupsToolbar::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  include ApplicationHelper
  attr_reader :current_user
  option :current_user, default: proc { nil }
  option :current_org_unit, default: proc { nil }
  option :menu_option, default: proc { true }

  def view_filter_options
      [
        [I18n.t("devices.all_devices"), "all"],
        [I18n.t("organizations.locked_managed"), "locked"],
        [I18n.t("organizations.deprovisioned"), "deprovisioned"],
        [I18n.t("v2.filters.inactive"), "inactive"],
        [I18n.t("v2.filters.unlicensed"), "unlicensed"],
        [I18n.t("v2.filters.factory_reset"), "factory_reset"],
        [I18n.t("v2.filters.recently_added"), "recently_added"]
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
  