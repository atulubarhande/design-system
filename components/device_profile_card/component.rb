# frozen_string_literal: true

class DeviceProfileCard::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  include ApplicationHelper
  renders_one :permission
  renders_one :image # to render image after header text
  renders_one :label_image # to render image before header text
  def initialize(header:nil, hint:nil, value:nil, type:nil, default:nil, text_area_csv:nil, text_area:nil, text_input:nil, label:nil, id:nil, name:nil, rows:nil, cols:nil, placeholder:nil, style:nil, options:nil, checked:nil, checkbox:nil, css_class:nil, action: nil, number_value:nil, min:nil, max:nil, klasses: nil, header_classes: nil, select_container_classes: nil, data: nil, required: nil, toggle_class: nil, helper_text: nil)
    @header = header
    @hint = hint
    @selected = value
    @options = options
    @action = action
    @toggle = default
    @type = type
    @text_area = text_area
    @label = label
    @id = id
    @rows = rows
    @cols = cols
    @style = style
    @css_class = css_class
    @placeholder = placeholder
    @text_area_csv = text_area_csv
    @text_input = text_input
    @name = name
    @checked = checked
    @checkbox = checkbox
    @value = number_value
    @min = min
    @max = max
    @klasses = klasses
    @header_classes = header_classes
    @select_container_classes = select_container_classes
    @data = data
    @required = required
    @helper_text = helper_text
    @toggle_class = toggle_class
  end
end
  