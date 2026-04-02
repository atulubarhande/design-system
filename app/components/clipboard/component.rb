# frozen_string_literal: true

class Clipboard::Component < ViewComponent::Base
    renders_one :custom_label
    
    def initialize(value:, password_field: false, classes: nil, 
        container_classes: nil, is_text_area: false, readonly: true, 
        name: nil, data: { }, disabled: false, placeholder: nil, 
        required: false, maxlength: nil, textarea_height: "200px", minlength: nil, show_validation_errors: false,
        error_label_class: "" )

      @value = value
      @password_field = password_field
      @classes = classes
      @container_classes = container_classes
      @is_text_area = is_text_area
      @readonly = readonly
      @data = data
      @disabled = disabled
      @placeholder = placeholder
      @required = required
      @maxlength = maxlength
      @minlength = minlength
      @name = name
      @textarea_height = textarea_height
      @show_validation_errors = show_validation_errors
      @error_label_class = error_label_class
    end

    def custom_data
      @data.merge({ clipboard_target: 'source' })
  end
end
