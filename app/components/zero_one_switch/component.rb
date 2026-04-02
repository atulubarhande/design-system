# frozen_string_literal: true

class ZeroOneSwitch::Component < ApplicationViewComponent
    renders_one :custom_label

    option :id, default: proc { SecureRandom.uuid }
    option :name, default: proc { nil }
    option :label, default: proc { nil }
    option :description, default: proc { nil }
    option :checked, default: proc { false }
    option :value, default: proc { 0 }
    option :disabled, default: proc { false }
    option :data, default: proc { Hash.new }
    option :classes, default: proc { nil }
    option :action, default: proc { "" }
    option :container_classes, default: proc { "" } 

    def custom_data
        @data.merge({zero_one_switch_target: "switchCheckBox", action: "zero-one-switch#toggle #{@action}"})
    end
end
  