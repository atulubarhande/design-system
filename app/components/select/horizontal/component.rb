# frozen_string_literal: true

class Select::Horizontal::Component < Select::Component
  include Turbo::FramesHelper
  include ApplicationHelper
  option :label_col, default: proc { 6 }
  option :select_col, default: proc { 'bs-col' }
  option :postfix, default: proc { nil }
  option :platform, default: proc { nil }
end