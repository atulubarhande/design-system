# frozen_string_literal: true

class EmailField::Component < ApplicationViewComponent
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
    option :action, default: proc { nil }

    def merged_data
        @data.merge({ action: "validations#toggleEmailError #{@action}", validations_target: "email" })
    end
end
  