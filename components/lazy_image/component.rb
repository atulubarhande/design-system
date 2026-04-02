# frozen_string_literal: true

class LazyImage::Component < ApplicationViewComponent
    option :base64_placeholder, default: proc { "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==" }
    option :src, default: proc { @base64_placeholder }
    option :height, default: proc { 35 }
    option :width, default: proc { 35 }
    option :classes, default: proc { nil }
    option :data, default: proc { Hash.new }
end
  