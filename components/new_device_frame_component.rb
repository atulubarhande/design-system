class NewDeviceFrameComponent < ViewComponent::Base
  renders_one :action
  def initialize(type:, name: "Scalefusion", bar_color: "rgb(0, 150, 136)", wallpaper: nil, hide_nav: false, brand:, device_frame_height: nil, device_frame_width: nil,
      device: nil, profile: nil)
    @type = type
    @name = name
    @bar_color = bar_color
    @wallpaper = wallpaper
    @hide_nav = hide_nav
    @brand = brand
    @device_frame_height = device_frame_height
    @device_frame_width = device_frame_width
    @device = device
    @profile = profile
  end

  def wallpaper
    @brand&.wallpaper&.url || default_wallpaper
  end

  def logo
    @brand&.logo&.thumb&.url || default_logo
  end

  def default_wallpaper 
    asset_path('v2/bg/img_wallpaper_default@2x.png')
  end

  def bar_color
    @brand&.bar_color || @bar_color
  end

  def default_logo
    if @profile&.present? && @profile&.user&.reseller&.subdomain&.logo&.url.present?
      asset_path(@profile&.user&.reseller&.subdomain&.logo&.url)
    elsif @brand&.user&.reseller&.subdomain&.logo&.url.present?
      asset_path(@brand&.user&.reseller&.subdomain&.logo&.url)
    else
      asset_path('logo/sf_mark.svg')
    end
  end

  def is_android
    @type == 'android'
  end

  def show_device_name
    @brand&.name_visible
  end

  def show_brand_name
    @brand&.brand_name_visible
  end

  def show_logo_position
    @brand&.brand_logo_position
  end

  def is_ios
    @type == 'ios'
  end

  def is_windows
    @type == 'windows'
  end

  def is_mac
    @type == 'mac'
  end

  def is_nix
    @type == 'nix'
  end

  def is_apple_tv
    @type == 'apple_tv'
  end

  def chromeos?
    @type == 'chromeos'
  end

  def render?
    @type.present?
  end

  def ios_wallpaper
    # TODO: check lockscreen enabled
    # brand.lockScreenEnabled = false;
    # TODO: Only thumb should be used
    # @brand&.ios_home_wallpaper&.thumb&.url || default_wallpaper 
    @brand&.ios_home_wallpaper&.url || default_wallpaper
  end 

  def ios_lock_wallpaper
    # TODO: check lockscreen enabled
    # brand.lockScreenEnabled = false;
    @brand&.ios_lock_screen_wallpaper&.thumb&.url || default_wallpaper
  end 

  def windows_wallpaper
    # TODO: check lockscreen enabled
    # brand.lockScreenEnabled = false;
    # 
    # if device is present, then check if device_profile_id is present
    # if device_profile_id is present, then use windows_home_screen_wallpaper
    # if device_profile_id is not present, then use default_wallpaper
    if @device.present?
      (@device&.device_profile_id.present? && @brand.present?) ? @brand&.windows_home_screen_wallpaper&.thumb&.url : default_wallpaper
    else
      @brand&.windows_home_screen_wallpaper&.thumb&.url || default_wallpaper
    end

  end 

  def apple_tv_wallpaper
    asset_path('TV-UI.png')
  end

  def windows_lock_wallpaper
    # TODO: check lockscreen enabled
    # brand.lockScreenEnabled = false;
    @brand&.windows_lock_screen_wallpaper&.thumb&.url || default_wallpaper
  end

  def has_windows_lockscreen_wallpaper
    @brand&.windows_lock_screen_wallpaper&.thumb&.url.present?
  end

  def has_ios_lockscreen_wallpaper
    @brand&.ios_lock_screen_wallpaper&.thumb&.url.present?
  end

  def is_advanced_branding
    @type == 'advanced_branding'
  end
  
  def mac_wallpaper
    @brand&.macos_home_wallpaper&.thumb&.url || default_wallpaper
  end

  def chromeos_device_wallpaper
    @brand&.chromeos_device_wallpaper&.thumb&.url || default_wallpaper
  end

  def chromeos_user_wallpaper
    @brand&.chromeos_user_wallpaper&.thumb&.url || default_wallpaper
  end

  def chromeos_guest_wallpaper
    @brand&.chromeos_guest_wallpaper&.thumb&.url || default_wallpaper
  end
         
end
  