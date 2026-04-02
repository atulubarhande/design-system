class Elements::ButtonGroupComponent < ViewComponent::Base
  renders_one :title

  def initialize(title:, id:, show_search:nil, width: "tw-w-56")
    @title = title
    @id = id
    @width = width
    @show_search = show_search
  end

  def show_dropdown
    content.present?
  end

  def render?
    @id.present?
  end
end
  