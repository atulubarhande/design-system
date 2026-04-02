class LocationTrackingButton::Component < ApplicationViewComponent
    renders_many :buttons
    option :name, default: proc { nil }
    option :value, default: proc { nil }
    option :data, default: proc { Hash.new }
    option :type, default: proc { "radio" }
    option :checked, default: proc { nil }
    option :disabled, default: proc { nil }
    option :owner, default: proc { nil }

    def active_position
        radio_buttons.find_index { |radio| radio[:value] == @owner.user_subscription[:location_tracking_mode] }
    end

    def radio_buttons 
        [
            { label: I18n.t('v2.global_settings.location.mode_essential'), value: "essential"},
            { label: I18n.t('v2.global_settings.location.mode_basic'), value: "basic"},
            { label: I18n.t('v2.global_settings.location_mode_high_accuracy'), value: "high_freq" },
            { label: I18n.t('v2.global_settings.location.fleet_tracking'), value: "fleet_tracking" }
        ]
    end

end