# frozen_string_literal: true

class RemoteCommandFileInfo::Component < ApplicationViewComponent
    include ApplicationHelper
    option :report, default: proc { nil }
    option :attr_name, default: proc { nil }
    option :is_file, default: proc { true }
end
  