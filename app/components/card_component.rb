class CardComponent < ViewComponent::Base
    renders_one :card_header, CardHeaderComponent
    renders_one :footer

    def initialize(has_padding: nil, classes: "bs-p-4", height: nil, card_classes: '', parent_height: "bs-h-100", has_border: false, styles: '')
      @has_padding = has_padding
      @classes = classes
      @height = height
      @card_classes = card_classes
      @parent_height = parent_height
      @has_border = has_border
      @styles = styles
    end
end
