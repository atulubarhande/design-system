class ConfirmPassword::Component < ApplicationViewComponent
    include UserHelper
    renders_one :footer
    option :current_user, default: proc { nil }
    option :show_cancel_button, default: proc { true }
    option :field_name, default: proc { "password" }
    option :pin_name, default: proc { "pin" }

    def is_sf_account
        sign_up_type(@current_user) == "SF Account"
    end
end