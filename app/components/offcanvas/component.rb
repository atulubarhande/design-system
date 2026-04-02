# frozen_string_literal: true

class Offcanvas::Component < ApplicationViewComponent
  renders_one :title
  renders_one :footer
  
  option :body_class, default: proc { nil }
  option :show_close, default: proc { true }
  option :backdrop, default: proc { true }
  option :close_on_submit, default: proc { false }
  option :dismiss_canvas_action, default: proc { nil }
  option :header_classes, default: proc { nil }
  option :custom_width, default: proc { nil }
  option :turbo_submit, default: proc { nil }

end
  
