# frozen_string_literal: true

class GlobalTypehead::Component < ApplicationViewComponent
  include ApplicationHelper
  renders_one :custom_label
    
  option :id, default: proc { nil }
  option :name, default: proc { nil }
  option :label, default: proc { nil }
  option :action, default: proc { nil }
  option :has_groups, default: proc { true }
  option :placeholder, default: proc { nil }
  option :disabled, default: proc { false }
  option :required, default: proc { false }
  option :value, default: proc { nil }
  option :data, default: proc { Hash.new }
  option :read_only, default: proc { false }
  option :type, default: proc { "text" }
  option :min, default: proc { nil }
  option :max, default: proc { nil }
  option :minlength, default: proc { nil }
  option :maxlength, default: proc { nil }
  option :rows, default: proc { nil }
  option :cols, default: proc { nil }
  option :css_class, default: proc { nil }
  option :style, default: proc { nil }
  option :allowed_types, default: proc { [] }
  option :option_limits, default: proc { false }
  option :classes, default: proc { "" }
end
