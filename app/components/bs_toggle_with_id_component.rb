class BsToggleWithIdComponent < ViewComponent::Base
  attr_reader :margin
  def initialize(id:,name:, label:nil,description:nil, controller:'', action:'', checked:nil, input_action: nil, is_reverse: nil, margin: true)
    @id           = id
    @name         = name
    @label        = label
    @description  = description
    @controller   = controller
    @action       = action
    @checked      = checked
    @input_action = input_action
    @is_reverse   = is_reverse
    @margin       = margin
  end
end
