class CountryFlag::Component < ApplicationViewComponent
    option :contact_name, default: proc { nil }
    option :country_name, default: proc { nil }
    option :label, default: proc { nil }
    option :contact_value, default: proc { nil }
    option :country_value, default: proc { nil }
    option :maxlength, default: proc { 12 }
    option :disabled, default: proc { false }
    option :placeholder, default: proc { "8123456789" }
    option :data, default: proc { Hash.new }
    option :id, default: proc { nil}
    option :type, default: proc { "text" }
    option :required, default: proc { true }

    def custom_data
        @data.merge({ country_flag_target:"contact", intl_tel_input_id: @id, action: @country_name ? "country-flag#upateBothCountryAndContactNo" : "country-flag#onCountryChange #{@action}"})
    end

    def contact_number
        @country_name && @country_value ? "#{@country_value}#{@contact_value}" : @contact_value
    end
end
