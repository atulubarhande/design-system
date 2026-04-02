class BsDropdownComponent < ViewComponent::Base
  renders_one :title

  def initialize(title:, 
      id: "dropdownMenuButton1", 
      show_search:nil, 
      width: "150px", 
      is_left: false, 
      classes: nil, 
      auto_close: false, 
      data: {},
      card_classes: nil, 
      disabled: false, 
      dropdown_classes: nil,
      dropdown_data: {},
      custom_modal_height: nil
    )

    @title = title
    @id = id
    @width = width
    @show_search = show_search
    @is_left = is_left
    @classes = classes
    @auto_close = auto_close
    @data = data
    @card_classes = card_classes
    @disabled = disabled
    @dropdown_classes = dropdown_classes
    @dropdown_data = dropdown_data
    @custom_modal_height = custom_modal_height
  end

  def render?
    @id.present?
  end

  def dropdown_data
    @dropdown_data.merge({
      bs_toggle: "dropdown",
      bs_auto_close: ("outside" if @auto_close)
    })
  end
end
