class List::ListItemComponent < ViewComponent::Base
  renders_one :icon, IconComponent

  def initialize(title: nil)
    @title = title
  end
end
  