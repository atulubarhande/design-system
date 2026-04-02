# frozen_string_literal: true

class RolesAutoComplete::Component < ApplicationViewComponent
    include ApplicationHelper
    include V3::RolesHelper
    
    option :roles, default: proc { [] }
    option :device_admin, default: proc { Hash.new }
    option :action, default: proc { nil }

    def selected_role()
        selected_role = @roles.find { |role| role.id == @device_admin&.role_id }
        return selected_role unless selected_role.nil?
    end

end
  