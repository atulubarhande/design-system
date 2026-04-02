class AddNewUser::Component < ApplicationViewComponent
    include ApplicationHelper

    renders_one :hidden_input
    
    option :form_url, default: proc { nil }
    option :show_nix, default: proc { true }
    option :current_user, default: proc { nil }

end