class DeviceStatusComponent < ViewComponent::Base
    def initialize(provisioned_device:, status_icon: true, show_icon_text: false, licence_expired: false, device_inactive: nil, not_android_sf_app: true)
        @provisioned_device = provisioned_device
        @status_icon = status_icon
        @show_icon_text = show_icon_text
        @licence_expired = licence_expired
        @device_inactive = device_inactive
        @not_android_sf_app = not_android_sf_app
    end

    def is_windows
       return @provisioned_device.os == 'Windows'
    end

    def is_macOS
        return @provisioned_device.os == 'macOS'
    end

    def is_iOS
        return @provisioned_device.os == 'iOS'
    end

    def is_android
        return @provisioned_device.os == 'Android'
    end
    
    def is_printer
        return @provisioned_device.os == 'Printer'
    end
    
    def mode
        return @provisioned_device.mode 
    end

    def locked
        return @provisioned_device.locked
    end

    def is_inactive
        return @device_inactive.nil? ? @provisioned_device.inactive? : @device_inactive
    end

    def factory_reset
        return @provisioned_device.factory_reset
    end

    def state
        return @provisioned_device.state
    end

    def uninstalled
        return  @provisioned_device.android? ? @provisioned_device.gcm_disabled : @provisioned_device.mdm_removed?
    end

    def is_byod
        return @provisioned_device.mode == 'byod'
    end

    def is_kiosk
        return @provisioned_device.mode == 'kiosk'
    end

    def is_agent
        return @provisioned_device.mode == 'agent'
    end

    def is_null
        return @provisioned_device.mode.nil?
    end

    def is_activated
        return @provisioned_device.activated
    end

    def render_device_icon()
        if @licence_expired
           show_expire_status
        elsif factory_reset 
            factory_reset_device_icon
        elsif @not_android_sf_app && (is_macOS  || is_iOS) 
            mac_and_ios_device_icon
        elsif @not_android_sf_app && is_windows
            windows_device_status
        elsif @not_android_sf_app && is_printer
            printer_device_icon            
        else
            android_device_icon
        end        
    end

    def show_expire_status
        html = "<span>#{I18n.t('devices.unlicenced_or_expired')}</span>"
        html.html_safe
    end

    def android_device_icon
        html = ''
        if !is_activated
            html += @status_icon ? "<i class='zmdi zmdi-badge-check bs-text-secondary'></i>" : "<span>#{I18n.t('devices.not_activated')}</span>"
            html += "<span>#{I18n.t('devices.not_activated')}</span>" if @show_icon_text
        elsif uninstalled
            html += uninstalled_icon
        elsif is_inactive
            html += inactive_android_ios_mac_device_status
        elsif is_kiosk || is_agent || is_null 
             if locked
                html += lock_success_icon(I18n.t('common.locked')) 
            else
                html += lock_open_danger_icon(I18n.t('common.unlocked'))
            end
        else
            if is_byod
                html += byod_device_status
            end
        end
        html.html_safe
    end

    def mac_and_ios_device_icon
        html = ''
        if uninstalled 
            html += uninstalled_icon
        elsif is_inactive
            html += inactive_android_ios_mac_device_status
        elsif is_byod
            html += byod_device_status
        else
            if locked
                html += lock_success_icon(I18n.t('devices.managed'))
            else
                html += lock_open_danger_icon(I18n.t('devices.unmanaged'))
            end
        end
        html.html_safe
    end

    def windows_device_status
        html = ''
        if is_byod
            html += byod_device_status
        else
            if locked
                #windowsLockedState 
                if is_inactive
                    html += @status_icon ? "<i class='zmdi zmdi-lock bs-text-secondary'></i>" : "<span>#{I18n.t('devices.inactive')}</span>"
                    html += "<span>#{I18n.t('devices.inactive')}</span>" if @show_icon_text
                else
                    html +=  lock_success_icon(I18n.t('devices.managed'))
                end
            else
             #windowsUnlockedState
             html += lock_open_danger_icon(I18n.t('devices.unmanaged'))
            end
        end
        html.html_safe
    end

    def byod_device_status
        html = ''
        if locked
            html += @status_icon ? "<i class='zmdi byod-device-view byod-list-icon byod-device-managed-view-icon'></i>" : "<span>#{I18n.t('devices.managed')}</span>"
            html += "<span>#{I18n.t('devices.managed')}</span>" if @show_icon_text
        else
            html += @status_icon ? "<i class='zmdi byod-list-icon byod-device-view byod-device-unmanaged-view-icon bs-fs-2'></i>" : "<span>#{I18n.t('devices.unmanaged')}</span>"
            html += "<span>#{I18n.t('devices.unmanaged')}</span>" if @show_icon_text
        end
        html.html_safe
    end

    def factory_reset_device_icon
        html = ''
        if state == 'api_blocked'
            html += @status_icon ? "<i class='zmdi zmdi-replay zmdi-hc-flip-horizontal bs-text-danger'></i>" : "<span>#{I18n.t("devices.unmanaged")}</span>"
            html += "<span>#{I18n.t("devices.unmanaged")}</span>" if @show_icon_text
        else
            if @status_icon
                html += "<i class='zmdi zmdi-replay zmdi-hc-flip-horizontal bs-text-danger'></i>"
            else
                html += if @provisioned_device.ios? && @provisioned_device.return_service_setting_enabled?
                            "<span>#{I18n.t("common.rts")}</span>"
                        else
                            "<span>#{I18n.t("common.reset")}</span>"
                        end 
            end
            html += "<span>#{I18n.t("common.reset")}</span>" if @show_icon_text
        end
        html.html_safe
    end

    def inactive_android_ios_mac_device_status
        html = ''
        if locked
            if is_byod
                html +=  @status_icon ? "<i class='zmdi byod-device-view byod-list-icon byod-device-managed-view-icon byod-image-opacity'></i>" : "<span>#{I18n.t('devices.inactive')}</span>"
                html += "<span>#{I18n.t('devices.inactive')}</span>" if @show_icon_text
            else
                html += @status_icon ? "<i class='zmdi zmdi-lock bs-text-secondary'></i>" : "<span>#{I18n.t('devices.inactive')}</span>"
                html += "<span>#{I18n.t('devices.inactive')}</span>" if @show_icon_text
            end
        else
            if is_byod
                html += @status_icon ? "<i class='zmdi byod-list-icon byod-device-view byod-device-unmanaged-view-icon byod-image-opacity bs-fs-2'></i>" : "<span>#{I18n.t('devices.inactive')}</span>"
                html += "<span>#{I18n.t('devices.inactive')}</span>" if @show_icon_text
            else
                html +=  @status_icon ? "<i class='zmdi zmdi-lock-open bs-text-secondary'></i>" : "<span>#{I18n.t('devices.inactive')}</span>"
                html += "<span>#{I18n.t('devices.inactive')}</span>" if @show_icon_text
            end
        end
        html.html_safe 
    end

    def uninstalled_icon
        html = ''
        html += @status_icon ? "<i class='zmdi zmdi-delete bs-text-danger'></i>": "<span>#{I18n.t('devices.unenrolled')}</span>"
        html += "<span>#{I18n.t('devices.unenrolled')}</span>" if @show_icon_text
        html.html_safe
    end

    def lock_success_icon(status)
        html = ''
        html += @status_icon ? "<i class='zmdi zmdi-lock bs-text-success'></i>" : "<span>#{status}</span>"
        html += "<span>#{status}</span>" if @show_icon_text
        html.html_safe
    end

    def lock_open_danger_icon(status)
        html = ''
        html += @status_icon ? "<i class='zmdi zmdi-lock-open bs-text-danger'></i>" : "<span>#{status}</span>"
        html += "<span>#{status}</span>" if @show_icon_text
        html.html_safe
    end

    def printer_device_icon
        html = ''
        is_unmanaged = @provisioned_device.device_profile_id.nil?
        icon_color = @provisioned_device.device_inactive? ? "bs-text-secondary" : @provisioned_device.printer_system&.current_status == 'READY'  ? 'bs-text-success' : 'bs-text-danger'
        icon = is_unmanaged ? "<i class='zmdi zmdi-lock-open #{icon_color}'></i>": "<i class='zmdi zmdi-lock #{icon_color}'></i>"
        if is_inactive || @provisioned_device.printer_system&.current_status == 'OFFLINE'
            html +=  @status_icon ? icon : "<span>#{I18n.t('devices.inactive')}</span>"
            html += "<span>#{I18n.t('devices.inactive')}</span>" if @show_icon_text
        else
            html += @status_icon ? icon : "<span>#{I18n.t(@provisioned_device.device_profile_id.nil? ? 'devices.unmanaged' : 'devices.managed')}</span>"
            html += "<span>#{I18n.t(@provisioned_device.device_profile_id.nil? ? 'devices.unmanaged' : 'devices.managed')}</span>" if @show_icon_text
        end
        html.html_safe
    end
end 