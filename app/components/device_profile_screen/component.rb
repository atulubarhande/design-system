# frozen_string_literal: true

class DeviceProfileScreen::Component < ApplicationViewComponent
    include Turbo::FramesHelper
    include ApplicationHelper
    include BrandsHelper
    
    option :device_profile, default: proc { nil }
    option :current_user, default: proc { nil }
    option :default_name, default: proc { "Scalefusion" }

    def render?
        @device_profile.present?
    end

    def check_brand
        @device_profile&.brand&.present? ? @device_profile&.brand : Brand.new(name_visible: true)
    end

    def brand_name
        @device_profile&.brand&.present? ? check_brand&.name : @default_name
    end

end
