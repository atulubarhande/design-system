class BrowserInfoComponent < ViewComponent::Base
  def initialize(title: nil, description: nil, icon_src: nil)
    @title   = title
    @description = description
    @icon_src = icon_src
  end
end
