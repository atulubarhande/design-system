# frozen_string_literal: true

class Store::AppInfo::Component < ApplicationViewComponent
  include ApplicationHelper
  option :app, default: proc { nil }
  option :current_user, default: proc { nil }
  option :latest_release, default: proc { nil }
  option :installed_on, default: proc { nil }
  option :published_to, default: proc { nil }
  option :is_open, default: proc { false }
  option :app_version, default: proc { false }
  option :previous_releases, default: proc { Array.new }
  option :previous_releases_count, default: proc { 0 }

  renders_many :actions


  def app_type 
    [current_user.id, current_user.parent_id].include?(@app.owner.id) ? 'myApps' : 'recommendedApps'
  end 

  def uninstallable_app?
    if @app.recommended?
      @app.wingman_app ? false : !@app.app_mobilock?
    else
      @app.app_mobilock? ? false : true
    end
  end
  
end
  