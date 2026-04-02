class BsToggleComponent < ViewComponent::Base
  renders_one :custom_label
  attr_reader :margin
  include Turbo::FramesHelper
  include ApplicationHelper
  def initialize(id: SecureRandom.uuid,
      name: ,
      input_name: nil,
      label: nil,
      description: nil,
      controller:'',
      action: nil,
      checked: nil,
      input_action: nil,
      is_reverse: nil,
      margin: true,
      required: nil,
      disabled: nil,
      data: Hash.new,
      platform_logo: nil, 
      automation_class: nil,
      value: nil,
      lable_classes: nil,
      hidden_field: true,
      data_hf: nil,
      classes: nil,
      parent_class: "bs-flex-row-reverse",
      show_at_start: false)

    @id           = id
    @name         = name
    @input_name   = input_name
    @label        = label
    @description  = description
    @controller   = controller
    @action       = action
    @checked      = checked
    @input_action = input_action
    @is_reverse   = is_reverse
    @margin       = margin
    @required     = required
    @disabled     = disabled
    @platform_logo= platform_logo
    @data         = data 
    @value        = value   unless value.nil?
    @automation_class = automation_class
    @lable_classes = lable_classes
    @hidden_field = hidden_field
    @parent_class = parent_class
    @data_hf = data_hf
    @classes = classes
    @show_at_start = show_at_start
  end
end