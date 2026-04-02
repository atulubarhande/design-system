# frozen_string_literal: true

class ListBottomObserver::Component < ApplicationViewComponent
  renders_one :list
  option :aria, default: proc { nil }
end
  