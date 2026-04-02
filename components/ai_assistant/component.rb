class AiAssistant::Component < ApplicationViewComponent
    include ApplicationHelper

    option :context, default: proc { String }
    option :current_user, default: proc { String }
end