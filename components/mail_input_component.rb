# frozen_string_literal: true

class MailInputComponent < ViewComponent::Base
  renders_one :icon

  def initialize(id: nil, value:nil, name: nil, data: nil, required: nil, controller: "mail", type: "email", action: nil, min:nil, max: nil, pattern: nil, target: "input", label: nil, autofocus:nil, placeholder: nil, multiple: false)
    @id       = id
    @value    = value
    @name     = name
    @data     = data
    @type     = type
    @pattern  = pattern
    @min      = min
    @max      = max
    @label    = label
    @target   = target 
    @required    = required 
    @autofocus   = autofocus
    @controller  = controller
    @action      = action
    @placeholder = placeholder
    @multiple    = multiple
  end
end
