
class NumberInputComponent < ViewComponent::Base
  
    def initialize(id: nil, 
      value: nil, 
      name: nil, 
      required: nil,
      type: "text",
      min: nil,
      max: nil,
      label: nil,
      placeholder: nil,
      start: nil,
      step: nil,
      controller: nil,
      data: nil,
      action: nil,
      disabled: nil)


      @id       = id
      @value    = value
      @name     = name
      @type     = type
      @min      = min
      @max      = max
      @label    = label 
      @required    = required 
      @placeholder = placeholder
      @start = start
      @step = step
      @controller = controller
      @data = data
      @action = action
      @disabled = disabled
    end
  end
  