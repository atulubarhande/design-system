# frozen_string_literal: true

class Button::Component < ApplicationViewComponent
  renders_one :loading_icon
  renders_one :leading_icon
  renders_one :trailing_icon

  option :label, default: proc { nil }
  option :icon, default: proc { nil }
  option :variant, default: proc { "primary" }
  option :size, default: proc { "md" }
  option :disabled, default: proc { false }
  option :loading, default: proc { false }
  option :type, default: proc { "button" }
  option :href, default: proc { nil }
  option :target, default: proc { nil }
  option :data, default: proc { Hash.new }

  def button_variant_class
    variant_classes = {
      "primary" => "bs-btn bs-radius-md bs-btn-brand-primary",
      "secondary" => "bs-btn bs-radius-md bs-btn-brand-secondary",
      "tertiary" => "bs-btn bs-radius-md bs-btn-brand-tertiary",
      "destructive" => "bs-btn bs-radius-md bs-btn-destructive-primary",
    }
    variant_classes[@variant]
  end
end
