class CardHeaderComponent < ViewComponent::Base
  renders_one :title

  def initialize(bg_class: "", align_contents: "center", data: nil, styles: '')
    @bg_class = bg_class
    @align_contents = align_contents
    @data = data
    @styles = styles
  end
end
