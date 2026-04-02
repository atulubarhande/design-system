# frozen_string_literal: true

class OsIcon::Component < ApplicationViewComponent
    option :platforms, default: proc { Array.new }
    option :device_mode, default: proc { nil }

    def render?
        @platforms.present?
    end
end
  