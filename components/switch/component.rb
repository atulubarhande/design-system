# frozen_string_literal: true

class Switch::Component < ApplicationViewComponent
    renders_one :custom_label

    
    option :id, default: proc { SecureRandom.uuid }
    option :name, default: proc { nil }
    option :label, default: proc { nil }
    option :default_value, default: proc { false }
    option :description, default: proc { nil }
    option :checked, default: proc { false }
    option :value, default: proc { true }
    option :disabled, default: proc { false }
    option :data, default: proc { Hash.new }
    option :classes, default: proc { nil }
    option :hidden_input_data, default: proc { Hash.new }
    option :has_true_or_false, default: proc { false }
    option :container_classes, default: proc { "" } 
end
  