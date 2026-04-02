# frozen_string_literal: true

class TextField::Component < ApplicationViewComponent
    renders_one :custom_label
    
    option :name, default: proc { nil }
    option :label, default: proc { nil }
    option :placeholder, default: proc { nil }
    option :disabled, default: proc { false }
    option :required, default: proc { false }
    option :value, default: proc { nil }
    option :data, default: proc { Hash.new }
    option :read_only, default: proc { false }
    option :type, default: proc { "text" }
    option :description, default: proc { nil }
    option :postfix, default: proc { nil }
    option :pattern, default: proc { nil }
    option :min, default: proc { nil }
    option :max, default: proc { nil }
    option :minlength, default: proc { nil }
    option :maxlength, default: proc { nil }
    option :error_label_class, default: proc { nil }
    option :id, default: proc { nil }
    option :classes, default: proc { "bs-my-3" }
    option :input_class, default: proc { nil }
    option :fontsize, default: proc { 6 }
    option :step, default: proc { "" }
    option :form, default: proc { nil }
    option :inputmode, default: proc { nil }

    def custom_data
		{ controller:"field-validation" }
    end 

end
  