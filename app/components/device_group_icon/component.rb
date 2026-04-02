# frozen_string_literal: true

class DeviceGroupIcon::Component < ApplicationViewComponent
    option :group, default: proc { Hash.new }
    option :id, default: proc { SecureRandom.uuid }
    def render?
        @group.present?
    end
end
  