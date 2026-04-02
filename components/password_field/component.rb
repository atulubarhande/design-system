# frozen_string_literal: true

class PasswordField::Component < ApplicationViewComponent
    renders_one :custom_label
    
    option :name, default: proc { nil }
    option :label, default: proc { nil }
    option :placeholder, default: proc { nil }
    option :disabled, default: proc { false }
    option :required, default: proc { false }
    option :value, default: proc { nil }
    option :data, default: proc { Hash.new }
    option :read_only, default: proc { false }
    option :description, default: proc { nil }
    option :postfix, default: proc { nil }
    option :pattern, default: proc { nil }
    option :min, default: proc { nil }
    option :max, default: proc { nil }
    option :minlength, default: proc { nil }
    option :maxlength, default: proc { nil }
    option :generate_password, default: proc { false }

    def custom_data
		  { controller:"field-validation" }
    end

end
  