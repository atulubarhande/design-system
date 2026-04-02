# frozen_string_literal: true

class Store::TableCell::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  option :item, default: proc { nil }
end
  