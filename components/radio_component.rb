class RadioComponent < ViewComponent::Base
  renders_one :custom_label
  def initialize(id: ,name:, label: nil, value:, checked: false, action: nil, data: nil, description: nil, wrapper_class: 'bs-my-3', disabled: false, lable_classes: nil, classes: '')
    @id = id
    @name = name
    @label = label
    @value = value
    @checked = checked
    @action = action
    @data = data
    @description  = description
    @disabled = disabled
    @wrapper_class = wrapper_class
    @lable_classes = lable_classes
    @classes = classes
  end
end
