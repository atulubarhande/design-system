class DynamicFieldComponent < ViewComponent::Base
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
      start: nil,
      step: nil,
      disabled: false,
      controller: nil,
      options: [],
      data: nil,
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
      @required    = required 
      @placeholder = placeholder
      @start = start
      @step = step
      @controller = controller
      @options = options
      @data = data
      @disabled = disabled
      @action = action

      manage_action_data
    end

    def manage_action_data
      return if @type != 'text'

      @data ||= ""

      @data += "data-typehead-target=textarea" 
      
      if(@action)
        @action += " typehead#onChange"
      end
    end

    def is_checked(option)
      return false unless @value.is_a?(Hash)
      checked_value = @value.select { |key, value| value.to_s == 'true' }
      @type == 'checkbox' && checked_value.keys.include?(option)
    end
  end
  