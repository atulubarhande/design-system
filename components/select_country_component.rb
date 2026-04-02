class SelectCountryComponent < ViewComponent::Base
    include V3::SelectCountryHelper
    def initialize(id: nil, name: nil, label: nil, options: nil, required: nil, value: nil)
        @id       = id
        @name     = name
        @label    = label
        @options = options
        @required  = required
        @value = value

    end

    def selected_country_name(code)
        option = plan_country_options.find { |option| option[:code] == code }
        return option[:name] if option
    end
end