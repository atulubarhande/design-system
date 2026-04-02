class CustomPayload::Component < ApplicationViewComponent
  include ApplicationHelper
  option :context, default: proc { nil }
  option :file_valid_extensions, default: proc { [] }
  option :placeholder, default: proc { "" }
  option :name, default: proc { nil }
  option :value, default: proc { "" }
  option :id, default: proc { "" }
  option :tip, default: proc { "" }
end
