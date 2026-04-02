class ListItemComponent < ViewComponent::Base
  renders_one :icon, IconComponent
  renders_one :title 

  def initialize(title: nil, classes: nil)
    @title = title
    @classes = classes
  end
end
