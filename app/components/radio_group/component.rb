# frozen_string_literal: true

class RadioGroup::Component < ApplicationViewComponent
    renders_one :custom_label
    
    option :id, default: proc { SecureRandom.uuid }
    option :name, default: proc { nil }
    option :input_name, default: proc { nil }
    option :selected, default: proc { nil }
    option :label, default: proc { nil }
    option :disabled, default: proc { false }
    option :data, default: proc { Hash.new }
    option :options, default: proc { [] }
end
