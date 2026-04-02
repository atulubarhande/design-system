# frozen_string_literal: true

class Devices::Filters::Component < ApplicationViewComponent
  include ApplicationHelper
  renders_one :custom_icon
  option :icon, default: proc { nil }
  option :heading, default: proc { nil }
  option :title, default: proc { nil }
  option :show_drop_down_arrow, default: proc { false }
end
  