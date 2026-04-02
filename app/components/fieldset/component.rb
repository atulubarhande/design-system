# frozen_string_literal: true

class Fieldset::Component < ApplicationViewComponent
    renders_one :custom_label
    option :label, default: proc { nil }
    option :classes, default: proc {""}
    option :fieldset_classes, default: proc { '' }
    option :fieldset_styles, default: proc { nil }
end
  