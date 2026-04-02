# frozen_string_literal: true

class SelectedDeviceGroupsBadges::Component < ApplicationViewComponent
    option :groups, default: proc { [] }
    option :visible_chip_count, default: proc { 2 }
    option :is_array, default: proc { false }
end
  