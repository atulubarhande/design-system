# frozen_string_literal: true

class Stepper::Component < ApplicationViewComponent
  option :id, default: proc { "stepper" }
  option :action, default: proc { "" }
  option :tab_count, default: proc { "" }
  option :has_dynamic_tab, default: proc { false }
  option :button_text, default: proc { I18n.t("common.save") }
end
