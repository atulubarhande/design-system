class Elements::CardComponent < ViewComponent::Base
    renders_one :card_header, CardHeaderComponent
  
    def initialize(has_padding: nil)
      @has_padding = has_padding
    end
end
  