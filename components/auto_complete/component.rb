# frozen_string_literal: true

class AutoComplete::Component < ApplicationViewComponent
    option :app_id, default: proc { nil }
    option :selected, default: proc { nil }
    option :action, default: proc { nil }
end
  