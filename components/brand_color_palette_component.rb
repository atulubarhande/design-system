class BrandColorPaletteComponent < ViewComponent::Base
  include BrandsHelper
  renders_one :dropdown, BsDropdownComponent
  attr_reader :brand

  def initialize(brand: nil, name: , value: ,action: nil, input_target: nil, on_palette_click: nil, on_hex_input_change: nil, label:, color_name_target:, color_target:, invalid_message_target:, classes: nil, palette_target_controller: 'advanced-branding', branding: 'branding', placeholder: '#000', on_keydown: nil, disabled: false)
    @brand   = brand
    @name    = name
    @value   = value
    @action  = action
    @input_target = input_target
    @on_palette_click = on_palette_click
    @on_hex_input_change = on_hex_input_change
    @label = label
    @classes = classes
    @palette_target_controller = palette_target_controller
    @branding = branding
    @on_keydown = on_keydown
    @color_name_target = color_name_target
    @color_target = color_target
    @invalid_message_target = invalid_message_target
    @disabled = disabled
    @placeholder = placeholder
  end

  def bar_color
      @brand&.bar_color || "#19B491"
  end

  def colors
    current_bar_color_name(@value || "#19B491")
  end 
  
end
  