# frozen_string_literal: true

class Store::Enterprise::AppCard::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  include ApplicationHelper
  include StoreAppsHelper
  attr_reader :app
  renders_one :footer
  option :app, default: proc { Hash.new }
  option :app_type, default: proc { nil }
  
  option :label, default: proc { nil }
  option :logo, default: proc { nil }
  option :rbac, default: proc { false }
  option :current_user, default: proc { nil }

  def app_label 
    @app&.[](:label) || @app&.[](:name)
  end

  def app_icon
    case app.class.to_s
    when "Script"
      app&.windows? ? app&.icon_url.present? ? app&.icon_url : asset_path('v2/icons/windows_enterprise_apps/ic-ps1.svg') : asset_path("v2/icons/apple_apps/mac-sh.svg")
    when "IosEnterpriseApp"
      app&.icon_url || IosEnterpriseApp.default_icons[app&.app_type]
    when "StoreApp"
      app&.app_icon_url
    when "ItunesRecommendedApp"
      app&.icon_url
    when "AppleEnterpriseBook"
      app&.book_type == "epub" ? asset_path("v2/icons/apple_apps/ic-epub.svg") : asset_path("v2/icons/apple_apps/ic-pdf.svg")
    when "Emm::Windows::EnterpriseApp"
      app&.app_icon_url.present? ? app&.app_icon_url : app["app_type"] == "msi" ? asset_path('v2/icons/windows_enterprise_apps/ic-msi.svg') : app["app_type"] == "exe" ? asset_path("v2/icons/windows_enterprise_apps/ic-exe.svg") : asset_path("v2/icons/windows_enterprise_apps/ic-uwp.svg")
    else
      ""
    end
  end 

  def app_os_name
    icon_class_name(true)
  end

  def filter_target
    icon_class_name(true, true)
  end

  def icon_class_name(has_os_name = false, filter = false)
    # had a chat with Atul sir this method needs major refactoring
    if  @app&.[](:app_type) == "pkg"
      return has_os_name ? "macOS" : asset_path('v2/icons/macos-app-icon.svg')
    end

    if @app.try(:supports_tvos?)
      return has_os_name ? "tvOS" : asset_path('v2/icons/apple-tv-icon.svg')
    end

    case app.class.to_s
    when "StoreApp"
      return has_os_name ? "Android" : asset_path('v2/icons/android-app-icon.svg')
    when "ItunesRecommendedApp", "AppleEnterpriseBook", "IosEnterpriseApp"
      return has_os_name ? app.class.to_s == "AppleEnterpriseBook" ? filter ? "ioS" : "book" : "iOS" : asset_path('v2/icons/ios-app-icon.svg')
    # when "IosEnterpriseApp"
    #   return has_os_name ? "macOS" : asset_path('v2/icons/macos-app-icon.svg')
    when "Emm::Windows::EnterpriseApp"
      return has_os_name ? "Windows" : asset_path('v2/icons/windows-app-icon.svg')
    when "Script"
      script_type = app&.nix? ? 'linux' : app&.script_type
      case script_type
      when "mac"
        return has_os_name ? "macOS" : asset_path('v2/icons/macos-app-icon.svg')
      when "linux"
        return has_os_name ? "Linux" : asset_path('v2/icons/nix-app-icon.svg')
      when "windows"
        return has_os_name ? "Windows" : asset_path('v2/icons/windows-app-icon.svg')
      end
    else
      return has_os_name ? "Android" : asset_path('v2/icons/android-app-icon.svg')
    end
  end

  def version_name
    publish_button_details(:version)
  end

  def publish_button_frame_id
    "app_details_card"
  end

  def publish_button_url
    publish_button_details(:url)
  end

  def updated_at
    publish_button_details(:updated_at)
  end

  def app_size
    publish_button_details(:size)
  end

  def update_app_url
    publish_button_details(:update)
  end

  def update_turbo_tag
    publish_button_details(:turbo)
  end
  
  def publish_button_details(type)
    # Handle @app hash case
    if @app&.[](:app_type) == "pkg"
      result = case type
        when :url
          ios_enterprise_app_path(app)
        when :updated_at
          app.latest_release.created_at.strftime('%b %d, %Y')
        when :version
          app&.latest_release&.release_version
        when :size
          number_to_human_size(app&.latest_release&.ipa_size)
        when :update
          upload_macos_pkg_file_user_mac_enterprise_apps_path
        when :turbo
          "upload_macos_pkg_file"    
        end
      return result
    end
    
  
    
    case app.class.to_s
    when "StoreApp"
      case type
      when :url
        store_app_details_path(app)
      when :version
        "#{app&.latest_release&.version_name}(#{app.latest_release.version_code if app.latest_release})"
      when :updated_at
        app&.latest_release&.created_at&.strftime('%b %d, %Y')
      when :size
        number_to_human_size(app&.latest_release&.apk_size)
      when :update
        upload_apk_user_store_index_path
      when :turbo
        "upload_android_app"    
      end
      
    when "IosEnterpriseApp"
      case type
      when :url
        ios_enterprise_app_path(app)
      when :updated_at
        app.latest_release.created_at.strftime('%b %d, %Y')
      when :version
        app&.latest_release&.release_version
      when :size
        number_to_human_size(app&.latest_release&.ipa_size)
      when :update
        upload_ipa_file_user_ios_enterprise_apps_path
      when :turbo
        "upload_ipa_file"    
      end
    when "AppleEnterpriseBook"
      case type
      when :url
        apple_enterprise_book_path(app)
      when :version
        1
      when :updated_at
        app&.created_at&.strftime('%b %d, %Y')
      when :size
        number_to_human_size(app.size)
      when :update
        upload_ios_app_user_ios_enterprise_apps_path
      when :turbo
        "upload_ios_app"   
      end
    when "Script"
      case type
      when :url
        script_path(app)
      when :version
        app&.latest_release&.version
      when :updated_at
        app&.latest_release&.created_at&.strftime('%b %d, %Y')
      when :size
        number_to_human_size(app&.latest_release&.size)
      when :update
        upload_linux_script_user_scripts_path
      when :turbo
        "upload_linux_script"  
      end
    when "Emm::Windows::EnterpriseApp"
      case type
      when :url
        windows_enterprise_app_path(app)
      when :version
        app&.latest_release&.version
      when :updated_at
        app&.latest_release&.created_at&.strftime('%b %d, %Y')
      when :size
        number_to_human_size(app&.latest_release&.size)
      when :update
        %w[exe uwp].include?(app[:app_type]) ? windows_enterprise_app_path(id: app.id) : app[:app_type] == 'msi' ? upload_msi_user_windows_enterprise_apps_path : upload_windows_apps_user_windows_enterprise_apps_path
      when :turbo
        case app[:app_type]
        when 'exe', 'uwp'
          'app_details_card'
        when 'msi'
          'upload_msi'
        else
          'upload_windows_app'
        end
      end
    when "ItunesRecommendedApp"
      case type
      when :url
        stats_emm_apple_app_mappings_path
      when :version
        app&.apple_app&.version_code
      when :updated_at
        app&.apple_app&.last_release_date&.strftime('%b %d, %Y')
      when :size
        number_to_human_size(app&.apple_app&.size)
      end
    end
  end

  def update_app?(app)
    !(app.is_a?(Script) && app.script_type == "mac") &&
      app.class.to_s != "AppleEnterpriseBook" &&  app.class.to_s != "Windows"
  end

  def get_platform_feature_flag
    app_type = @app&.[](:app_type)
    app_class = @app.class.to_s
    
    if %w[sh ps].include?(app_type) || app_class == 'Script'
      script_type = @app&.script_type
      case script_type
      when 'linux', 'nix'
        'nix'
      when 'mac'
        'macos'
      when 'windows'
        'windows'
      end
    elsif %w[ItunesRecommendedApp AppleEnterpriseBook IosEnterpriseApp].include?(app_class)
      app_type == 'pkg' ? 'macos' : 'ios'
    elsif app_class == 'Emm::Windows::EnterpriseApp'
      'windows'
    else
      'android'
    end
  end
end
  