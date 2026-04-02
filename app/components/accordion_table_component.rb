class AccordionTableComponent < ViewComponent::Base
  renders_one :header
  renders_one :actions
    def initialize(id:, title: "", is_open: false, remove_margin_padding: false, params: nil)
      @id = id
      @title = title
      @is_open = is_open
      @remove_margin_padding= remove_margin_padding
    end

  end
  