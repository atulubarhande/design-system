# frozen_string_literal: true

class Radio::Component < ApplicationViewComponent
    renders_one :custom_label
    
    option :id, default: proc { SecureRandom.uuid }
    option :name, default: proc { nil }
    option :checked, default: proc { false }
    option :label, default: proc { nil }
    option :value, default: proc { true }
    option :disabled, default: proc { false }
    option :data, default: proc { Hash.new }
    option :value, default: proc { true }
    option :default_value,  default: proc { true }
    option :description, default: proc { nil }
    option :required, default: proc { false }
    option :lable_classes, default: proc{"bs-text-body-secondary" }
end
