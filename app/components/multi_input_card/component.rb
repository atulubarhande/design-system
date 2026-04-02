class MultiInputCard::Component < ApplicationViewComponent
    include ApplicationHelper

    option :id, default: proc { SecureRandom.uuid }
    option :selected_value, default: proc { [] }
    option :name, default: proc { "" }
    option :placeholder, default: proc { "" }
    option :data, default: proc { {} }
    option :container_class, default: proc { "" }
    option :max_card, default: proc { 100000 }
    option :disabled, default: proc { false }
    option :max_error, default: proc { "" }
    option :container_data, default: proc { {} }
    option :required, default: proc { false }
    option :required_error, default: proc { "" }
    option :allowed_characters, default: proc { [] }
    option :allowed_char_length, default: proc { 1 }
    option :invalid_feedback, default: proc { nil }
    option :type, default: proc { "text" }

    def custom_data
        @data.merge({
            action: "keyup->multi-input-card#addItem keydown->multi-input-card#handleKeyDown #{@data[:action]}",
            multi_input_card_target: "inputField"
        })
    end

    def container_data
        @container_data.merge({
            multi_input_card_target: "container"
        })
    end
end