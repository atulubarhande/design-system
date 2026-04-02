# frozen_string_literal: true

class TextField::Horizontal::Component < TextField::Component
  option :label_col, default: proc { 6 }
  option :textfield_col, default: proc { 6 }
  option :postfix_col, default: proc { 0 }
  option :wrapper_class, default: proc { "bs-d-flex bs-align-items-end" }
  option :has_label_required, default: proc { false }
  option :font_size, default: proc { 6 }
  option :vertical_margin, default: proc { 3 }
end
