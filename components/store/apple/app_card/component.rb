# frozen_string_literal: true

class Store::Apple::AppCard::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  include ApplicationHelper
  include StoreAppsHelper
  renders_one :footer
  option :app, default: proc { Hash.new }
  option :app_type, default: proc { nil }
  
  option :label, default: proc { nil }
  option :logo, default: proc { nil }
  option :is_vpp_app, default: proc { false }
  option :publish_params, default: proc { Hash.new }
  option :current_user, default: proc { nil }
end
  