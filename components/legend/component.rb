# frozen_string_literal: true

class Legend::Component < ApplicationViewComponent
    renders_one :custom_label
    option :label, default: proc { nil }
    option :classes, default: proc { nil }
end
  