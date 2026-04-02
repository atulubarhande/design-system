# frozen_string_literal: true

class Store::AppCatalog::AppCard::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  include ApplicationHelper
  include StoreAppsHelper
  renders_one :footer
  option :app, default: proc { Hash.new }
  option :app_type, default: proc { nil }
  
  option :label, default: proc { nil }
  option :logo, default: proc { nil }
  option :bundle_id, default: proc { nil }
  option :current_user, default: proc { nil }
  option :is_catalog_app, default: proc { false }

  def app_description
    if app.respond_to?(:app_store) && !app.app_store.present?
      app&.publisher
    else
      @bundle_id || app&.app_store&.latest_version
    end
  end
end
  