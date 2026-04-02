# frozen_string_literal: true

class DemoVideoModal::Component < ApplicationViewComponent
    option :id, default: proc { "demo-video-modal" }
    option :src, default: proc { nil }
end
  