# frozen_string_literal: true

class TextArea::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  include ApplicationHelper

  def initialize(
      label: nil, 
      id: SecureRandom.uuid, 
      name: nil, 
      rows: 6, 
      cols: 6, 
      placeholder: nil, 
      style: nil, 
      value: nil, 
      css_class: "", 
      data: { }, 
      disabled: false, 
      required: false,
      read_only: false,
      maxlength: nil
    )

    @label = label 
    @id = id 
    @name = name 
    @rows = rows 
    @cols = cols 
    @maxlength = maxlength
    @placeholder = placeholder 
    @css_class = css_class
    @style = style 
    @value = value
    @data = data
    @disabled = disabled
    @required = required
    @read_only = read_only
    @maxlength = maxlength
  end

  def custom_data
		{ controller:"field-validation" }
  end
end
