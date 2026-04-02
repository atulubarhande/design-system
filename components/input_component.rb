# frozen_string_literal: true

class InputComponent < ViewComponent::Base
  renders_one :icon
  renders_one :custom_label

  def initialize(id: nil, value:nil, name: nil, data: nil, required: nil, controller: "input", type: "text", action: nil, min:nil, max: nil, pattern: nil, target: "input", label: nil, autofocus:nil, placeholder: nil, minlength: nil, maxlength: nil, oninvalid: nil, disabled: false, klasses: nil, lable_classes: nil, styles: nil, readonly: false)
    @id       = id
    @value    = value
    @name     = name
    @data     = data
    @type     = type
    @pattern  = pattern
    @min      = min
    @max      = max
    @label    = label
    @readonly = readonly
    @target   = target 
    @required    = required 
    @autofocus   = autofocus
    @controller  = controller
    @action      = action
    @placeholder = placeholder
    @minlength = minlength
    @maxlength = maxlength
    @klasses = klasses ? ("bs-form-control " + klasses) : "bs-form-control"
    @oninvalid = oninvalid
    @disabled = disabled
    @lable_classes = lable_classes
    @styles = styles
  end
end
