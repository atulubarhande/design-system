
class ChromeosTextAreaCsv::Component < ApplicationViewComponent
    include Turbo::FramesHelper
    include ApplicationHelper
    
    def initialize(label:nil, id:nil, name:nil, rows:nil, cols:nil, placeholder:nil, style:nil, value:nil, css_class:nil, data: nil, chrome_device_profile_target: nil, klasses: nil, half: false)
        @label = label
        @id = id
        @name = name
        @rows = rows
        @cols = cols
        @placeholder = placeholder
        @css_class = css_class
        @style = style
        @value = value
        @data = data
        @chrome_device_profile_target = chrome_device_profile_target
        @klasses = klasses
        @half = half
    end
  end

