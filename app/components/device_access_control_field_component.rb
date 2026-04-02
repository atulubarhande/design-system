class DeviceAccessControlFieldComponent < ViewComponent::Base
  renders_one :custom_label
  attr_reader :margin
  include Turbo::FramesHelper
  include ApplicationHelper
  def initialize(id: SecureRandom.uuid,
      name: ,
      value: nil,
      list: [],
      hidden_field_name: nil,
      data:'',
      label: nil,
      key_name: nil,
      field_type: 'Select',
      platform_logo: nil)

    @name              = name
    @platform_logo     = platform_logo
    @value             = value
    @list              = list
    @label             = label
    @data              = data
    @key_name          = key_name
    @field_type        = field_type
    @hidden_field_name = hidden_field_name
  end
end
