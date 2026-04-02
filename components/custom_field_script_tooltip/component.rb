# frozen_string_literal: true

class CustomFieldScriptTooltip::Component < ApplicationViewComponent
  option :custom_field, default: proc { nil }
  option :placement, default: proc { "bottom" }
  option :icon_class, default: proc { "bs-text-primary bs-ms-3" }
end

