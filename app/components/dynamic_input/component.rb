class DynamicInput::Component < ViewComponent::Base
    include ApplicationHelper
    include Turbo::FramesHelper
    def initialize(id: nil, 
      value: nil, 
      name: nil, 
      required: nil,
      type: "text",
      classes: nil,
      min: nil,
      max: nil,
      label: nil,
      checked: nil,
      placeholder: nil,
      infotext: nil,
      extra_text: nil,
      start: nil,
      step: nil,
      controller: nil,
      options: [],
      data: nil,
      labelClass: "bs-col-4",
      inputClass: "bs-col-8",
      action: nil)

      @id       = id
      @value    = value
      @name     = name
      @type     = type
      @classes  = classes
      @min      = min
      @max      = max
      @checked = checked
      @label    = label 
      @infotext = infotext
      @extra_text = extra_text
      @required    = required 
      @placeholder = placeholder
      @start = start
      @step = step
      @controller = controller
      @options = options
      @data = data
      @action = action
      @labelClass = labelClass
      @inputClass = inputClass
    end

  end
  