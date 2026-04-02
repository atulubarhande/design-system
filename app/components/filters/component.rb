# frozen_string_literal: true

class Filters::Component < ApplicationViewComponent
  include ApplicationHelper
  renders_one :icon
  option :icon, default: proc { nil }
  option :heading, default: proc { nil }
  option :title, default: proc { nil }
end
