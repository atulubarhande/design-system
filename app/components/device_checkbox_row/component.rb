# frozen_string_literal: true

class DeviceCheckboxRow::Component < ApplicationViewComponent
    include Turbo::FramesHelper
    attr_reader :device
    option :device, default: proc { nil }
    option :name, default: proc { "device_ids[]" }
    option :selected, default: proc { Array.new }
    option :disabled_selected, default: proc { false }
    option :data, default: proc { Hash.new }
    option :action, default: proc { "" }
    option :disabled, default: proc { false }

    def medged_input_data
        @data.merge({ checkbox_target: "checkbox", action: "checkbox#updateSelectAllState checkbox#updateFormInput #{@action}" })
    end

    def ui_disabled()
        @disabled_selected && @selected.present? && (@selected.include? @device.id.to_s)
    end

    def custom_data
        @data.merge({checkbox_target: "checkbox", action: "checkbox#updateSelectAllState #{@action}"})
    end

    def device_info
        if @device.try(:os_type) == "printer" && @device.try(:serial_no).present?
            { key: 'serial_no', value: @device.serial_no }
        elsif @device.respond_to?(:imei_no) 
            { key: 'imei_no', value: @device.imei_no }
        else
            {}
        end
    end
end
