# frozen_string_literal: true

class UpdateDeviceCustomFields::Component < ApplicationViewComponent
    option :csv_type, default: proc { nil }
    option :current_user, default: proc { nil }
    option :note, default: proc { nil }
end
  