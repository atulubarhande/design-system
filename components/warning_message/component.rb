# frozen_string_literal: true

class WarningMessage::Component < ApplicationViewComponent
    renders_one :custom_label
    option :label, default: proc { nil }
    option :classes, default: proc { nil }
end
  