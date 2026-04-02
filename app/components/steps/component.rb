# frozen_string_literal: true

class Steps::Component < ApplicationViewComponent
    option :id, default: proc { "stepper" }
    option :steps, default: proc { [] }
    option :show_next, default: proc { true }
    option :show_prev, default: proc { true }
    option :action_position, default: proc { "center" }
    option :disable_steps, default: proc { false }
    option :next_button_text, default: proc { I18n.t("common.next") }
    option :prev_button_text, default: proc { I18n.t("common.previous") }
    option :active_step_index,  default: proc { 0 }
    option :header_class, default: proc { ""}
    option :action_classes, default: proc { "" }
    
    renders_many :panels
    renders_one :complete_button
  end
  