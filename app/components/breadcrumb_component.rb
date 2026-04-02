class BreadcrumbComponent < ApplicationViewComponent
    renders_many :links
    renders_one :header
    
    def initialize(title:nil, hide_bread_crumbs: nil, home_url: nil, home_title: "", container_class: "bs-mb-4", list_title: nil, content_classes: "" )
      @title = title
      @hide_bread_crumbs = hide_bread_crumbs
      @home_url = home_url
      @home_title = home_title
      @container_class = container_class
      @list_title = list_title
      @content_classes = content_classes
    end
end
  