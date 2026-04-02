# frozen_string_literal: true

class Store::PlayApp::AppCard::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  include ApplicationHelper
  include StoreAppsHelper
  renders_one :footer
  option :app, default: proc { Hash.new }
  option :app_type, default: proc { nil }
  option :rbac, default: proc { false }
  
  option :label, default: proc { nil }
  option :logo, default: proc { nil }
  option :current_user, default: proc { nil }
end
  