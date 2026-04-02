class Navigation::BreadcrumbComponent < ViewComponent::Base
    renders_many :links
    
    def initialize(title:nil, hide_bread_crumbs: nil, home_url:, home_title: "")
      @title = title
      @hide_bread_crumbs = hide_bread_crumbs
      @home_url = home_url
      @home_title = home_title
    end
end
  