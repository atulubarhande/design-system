# frozen_string_literal: true

class Store::AppPublishHeader::Component < ApplicationViewComponent
  include ApplicationHelper
  renders_one :actions
  renders_one :meta_data
  option :name, default: proc { nil }
  option :logo, default: proc { nil }
  option :title_class, default: proc { "bs-fs-3" }
  option :rbac, default: proc { false }
  option :is_catalog_app, default: proc { false }

end
  