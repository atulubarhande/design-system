# frozen_string_literal: true

class InfoIcon::Component < ApplicationViewComponent
    option :tooltip, default: proc { nil }
    option :label, default: proc { nil }
    option :container_class, default: proc { "" }
    option :platform_logo, default: proc { nil }
    option :platform_height, default: proc { nil }
    option :icon_class, default: proc { "bs-ms-2" }
    
    def render?
        @tooltip.present?
    end
end
  