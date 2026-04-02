class DeviceProfileIconComponent < ViewComponent::Base

    def initialize(type:)
      @type = type
    end

    def render?
      @type.present?
    end

    def icon()
      case @type
      when "AndroidDeviceProfile"
        "v2/icons/platform_icons/android.svg"
      when "AppleDeviceProfile"
        "v2/icons/platform_icons/ios.svg"
      when "Emm::Mac::DeviceProfile", "MacDeviceProfile"
        "v2/icons/platform_icons/macos.svg"
      when "Emm::Windows::DeviceProfile", "WindowsDeviceProfile"
        "v2/icons/platform_icons/windows.svg"
      when "Emm::Nix::DeviceProfile", "NixDeviceProfile"
        "v2/icons/platform_icons/nix.svg"
      when "Emm::ChromeOs::DeviceProfile", "ChromeDeviceProfile"
        "v2/icons/platform_icons/google-chrome.svg"
      when "ios"
        "v2/icons/platform_icons/ios.svg"
      when "macOS", "macos"
        "v2/icons/platform_icons/macos.svg"
      when "Emm::Printer::PrinterDeviceProfile"
        "v2/icons/platform_icons/printers_black.svg"
      when 'AppleTv::DeviceProfile', 'AppleTvDeviceProfile'
        "v2/icons/apple-tv-icon.svg"
      else
        ""
      end
    end
end
  