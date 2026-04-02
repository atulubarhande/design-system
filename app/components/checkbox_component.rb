class CheckboxComponent < ViewComponent::Base
  renders_one :custom_label
  include ApplicationHelper
  def initialize(id: SecureRandom.uuid, name: , checked: , label: nil, action: nil, data: Hash.new, value: true,
                 default_value: true, css_class: "", disabled: false, title: nil, description: nil, platform_logo: nil, 
                 label_classes: "", checkbox_classes: "" )
    @id = id
    @name = name
    @checked = checked
    @label = label
    @action = action
    @data = data
    @value = value
    @default_value = default_value
    @css_class = css_class
    @title = title
    @disabled = disabled
    @title = title
    @description = description
    @platform_logo= platform_logo
    @label_classes = label_classes
    @checkbox_classes = checkbox_classes
  end

  def custom_data
    @data.merge({ action: "toggle-hidden-field#onCheck #{@action} #{@data[:action]}", toggle_hidden_field_target:"checkField" })
  end
end
