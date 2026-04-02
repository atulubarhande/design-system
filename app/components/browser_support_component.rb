class BrowserSupportComponent < ViewComponent::Base
    def initialize(browser: ,height: nil, width: nil, classes: "") 
      @browser = browser
      @height = height
      @width = width
      @classes = classes
    end
  
    def browsers 
      {
        chrome_browser: asset_path("v2/icons/chrome-browser.svg"),
        edge_browser: asset_path("v2/icons/edge-browser.svg"),
        firefox_browser: asset_path("v2/icons/firefox-browser.svg")
      }
    end
  
    def render?
      @browser.present?
    end
  end
  