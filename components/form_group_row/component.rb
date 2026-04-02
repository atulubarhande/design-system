# frozen_string_literal: true

class FormGroupRow::Component < ApplicationViewComponent
    renders_one :custom_label
    renders_one :input

    option :row_class, default: proc { "bs-my-3 bs-align-items-center" }
    option :col_classes, default: proc { [4, 4] }
    option :data, default: proc { Hash.new }
    option :revert_slot, default: proc { false }
end
  
