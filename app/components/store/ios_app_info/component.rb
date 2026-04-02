# frozen_string_literal: true

class Store::IosAppInfo::Component < ApplicationViewComponent
  include ApplicationHelper
  option :app, default: proc { nil }
  option :current_user, default: proc { nil }
  option :latest_release, default: proc { nil }
  option :installed_on, default: proc { nil }
  option :published_to, default: proc { nil }
  option :is_open, default: proc { false }
  option :app_version, default: proc { false }
  option :previous_releases, default: proc { Array.new }
  option :app_published, default: proc { false }
  option :expires_on, default: proc { nil }
  option :release_id, default: proc { nil }
  option :type, default: proc { nil }
  option :app_type, default: proc { nil }




  
  renders_many :actions
end
  