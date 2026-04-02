class PlatformSupportComponent < ViewComponent::Base
  def initialize(platform: nil , height: nil, classes: "") 
    @platform = platform
    @height = height
    @classes = classes
  end

  def platforms
    {
      android: asset_path("v2/icons/android-app-icon.svg"),
      ios: asset_path("v2/icons/ios-app-icon.svg"),
      ios_managed: asset_path("common-assets/ios-managed-stroke.svg"),
      ios_supervised: asset_path("common-assets/ios-supervised-stroke.svg"),
      ios_supervised_dark: asset_path("common-assets/ios-supervised-dark.svg"),
      windows: asset_path("v2/icons/windows-app-icon.svg"),
      mac: asset_path("v2/icons/new-macos-app-icon.svg"),
      macos: asset_path("v2/icons/new-macos-app-icon.svg"),
      apple_tv: asset_path("v2/icons/apple-tv-icon.svg"),
      tvos: asset_path("v2/icons/apple-tv-icon.svg"),
      mac_dark: asset_path("v2/icons/macos-app-icon-dark.svg"),
      iphone: asset_path("v2/icons/ios-app-icon.svg"),
      nix: asset_path("v2/icons/nix-app-icon.svg"),
      globalWorkflow: asset_path("v2/icons/global-icon.svg"),
      emm: asset_path("v2/icons/secure_settings_logos/afw-logo@2x.png"),
      air_think: asset_path("v2/icons/sage_v2.svg"),
      chrome: asset_path("chromeos/chromeos-stroke.svg"),
      printer: asset_path("v2/icons/platform_icons/printers_black.svg"),
      sf: asset_path('logo/sf_mark.svg'),
      upgrade_plan: asset_path("common-assets/upgrade-icon.svg"),
      ipados: asset_path("v2/icons/ipados.svg"),
      zebra: asset_path("v2/icons/ic-zebra-small@2x.png")
    }
  end

  def render?
    @platform.present?
  end
end
