# frozen_string_literal: true
class DeviceCard::Component < ApplicationViewComponent
  include DevicesHelper
  attr_reader :device
  option :device, default: proc { Hash.new }
  option :current_user, default: proc { nil }
  option :owner, default: proc { nil }

  def populate_header_colors()
    if device&.factory_reset || device&.state == 'apns_expired'
      @bg_color = 'bg-legacy-red'
      @text_color = 'fill-red'
    else
      @bg_color = device&.locked ? 'bg-legacy-green' : 'bg-legacy-red'
      @text_color = device&.locked ? 'fill-green' : 'fill-red'
    end
  end

  def icon_class
    "icon-container bs-d-flex bs-align-items-center bs-justify-content-center bs-rounded-circle bs-text-white"
  end

  def render?
    @device.present?
  end

  def format_enable_disable_info(value)
    if value == true
      I18n.t('common.enabled')
    elsif value == false
      I18n.t('common.disabled')
    else
      I18n.t('common.na')
    end
  end

  def group_name
    device&.device_group.present? ? device&.device_group&.name : (device&.user_group&.name || I18n.t('v3.groups.not_assigned'))
  end

  def group_title
    device&.user_group.present? ? I18n.t('common.user_group_name') : I18n.t('common.device_group_name')
  end
  
  def batter_status
    battery_status = device&.battery_status || 0
    status = ""
    status += battery_status > 0 ? "#{battery_status} #{I18n.t("v2.battery.percent_left")}" : I18n.t("common.not_available")
    status += " | #{I18n.t("common.charging")}" if device&.charging
    status += " | #{I18n.t("common.charged")}" if battery_status == 100 && !device&.charging
    status  
  end
end
  