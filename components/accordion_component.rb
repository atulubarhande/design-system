class AccordionComponent < ViewComponent::Base
  renders_one :header

  def initialize(id:, title: "", is_open: false, remove_margin_padding: false, action: nil, params: nil, classes: "")
    @id = id
    @title = title
    @is_open = is_open
    @remove_margin_padding= remove_margin_padding
    @action = action
    @classes = classes
  end
end
