# frozen_string_literal: true

class Store::AppCardHeader::Component < ApplicationViewComponent
  include ApplicationHelper
  renders_one :footer
  option :name, default: proc { nil }
  option :logo, default: proc { nil }
  option :product_id, default: proc { nil }
  option :is_google_play_app, default: proc { false }
  option :version, default: proc { "" }
  option :is_catalog_app, default: proc { false }
end
  