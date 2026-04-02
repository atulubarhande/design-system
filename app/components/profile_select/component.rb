class ProfileSelect::Component < ApplicationViewComponent
  renders_one :profiles_list
  renders_one :switch_profile_mode
  renders_one :selected_profile
  option :device_profiles, default: proc { nil }
  option :current_user, default: proc { nil }
  option :show_screen, default: proc { true }
  option :id, default: proc { "brands-search-list" }
  option :container_classes, default: proc { nil }
  option :placeholder_for_search, default: proc { I18n.t("common.type_to_search") }
  option :device_profile, default: proc { nil }

  def default_wallpaper 
    asset_path('v2/bg/img_wallpaper_default@2x.png')
  end

  # Not being used as we take list as a slot
  def wallpaper(profile)
    case profile.type
    when "AndroidDeviceProfile"
      profile&.brand&.wallpaper&.url
    when "AppleDeviceProfile"
      profile&.brand&.ios_home_wallpaper&.url
    when "Emm::Mac::DeviceProfile"
      profile&.brand&.macos_home_wallpaper&.thumb&.url
    when "Emm::Windows::DeviceProfile"
      profile&.brand&.windows_home_screen_wallpaper&.thumb&.url
    when "Emm::Nix::DeviceProfile"
      default_wallpaper
    when "AppleTv::DeviceProfile"
      asset_path('TV-UI.png')
    end
  end
end
