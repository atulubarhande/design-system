class BsTabComponent < ViewComponent::Base
  def initialize(id: SecureRandom.uuid,title:, bs_nav_class: "",  disabled_indexes:[],vertical: nil, action: nil, classes: nil, height: nil, content_classes: nil, panel_height: "", active_tab_index: 0, bs_pannel_class: "bs-col-10", bs_tab_class: "bs-col-2", pannel_background: "#f6f9fc", form_urls: {}, tab_ids: [], params: { }, turbo_frame: "") 
    @id = id
    @title = title
    @bs_nav_class = bs_nav_class
    @vertical = vertical
    @action = action
    @classes  = classes
    @tab_ids = tab_ids
    @height = height
    @content_classes = content_classes
    @active_tab_index = active_tab_index
    @panel_height = panel_height
    @bs_pannel_class = bs_pannel_class
    @bs_tab_class = bs_tab_class
    @pannel_background = pannel_background
    @disabled_indexes = disabled_indexes
    @form_urls = form_urls
    @params = params
    @turbo_frame = turbo_frame
  end

  def scroll_classes
    if @height
      "bs-overflow-auto bs-overflow-x-hidden bs-scroll-sm bs-pe-3"
    end
  end

  def border_classes
    return "bs-border" unless @bs_nav_class.include? "bs-nav-pills"
  end

  def bs_nav_type_class
    return "bs-nav-tabs" unless @bs_nav_class.include?("bs-nav-pills") || @bs_nav_class.include?("bs-nav-underline")
  end

  def nav_link_class
      return "bs-py-2 bs-py-3" unless @bs_nav_class.include? "bs-nav-pills"
  end

  renders_many :tabs
  renders_many :panels
end
