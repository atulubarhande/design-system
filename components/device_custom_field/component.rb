class DeviceCustomField::Component < ApplicationViewComponent
    include ApplicationHelper
    option :fields, default: proc { [] }
    option :name, default: proc { nil }
    option :is_device_group, default: proc { false }
    option :current_user, default: proc { nil }
    option :device, default: proc { nil }
end