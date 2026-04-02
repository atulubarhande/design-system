class NestedFormComponent < ApplicationViewComponent
    renders_one :custom_label
    renders_one :template
    renders_one :add_button
    renders_one :add_button_bottom

    option :action, default: proc { "" }
    option :has_header, default: proc { false }
    option :add_button_text, default: proc { I18n.t('common.add') }
    option :add_btn_classes, default: proc { "bs-mb-3" }
    option :add_button_data, default: proc { Hash.new }
    # i18n helper method t() translations error in view_component 3.8.0
    option :key_placeholders, default: proc { [] }
    option :value_placeholders, default: proc { [] }
    option :max_count, default: proc { nil }
    option :data, default: proc { Hash.new }
    option :is_destory_input, default: proc { false }
    option :label_class, default: proc { "bs-d-flex bs-align-items-center bs-justify-content-between" }
    option :add_button_action, default: proc { nil }
    option :tooltip_text, default: proc { nil }
    option :container_class, default: proc { "bs-my-3" }
    option :default_action_required, default: proc { true }
    option :show_single_field_remove_button, default: proc { true }

    def show_header
        @has_header && content.present?
    end

    def add_button_block
        return if add_button_bottom?

        if add_button?
            add_button
        else
            <<~HTML.html_safe
              <a href="#" class="bs-btn bs-btn-light bs-btn-link nested-form-close-btn bs-d-flex bs-align-items-center bs-justify-content-center bs-mb-3 bs-add_more_btn #{@add_btn_classes}"
                  data-action="#{custom_data_action}"
                  data-nested-form-target="addButton"
                  data-controller="tooltip"
                  data-bs-toggle="bs-tooltip"
                  data-bs-title="#{@tooltip_text}">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                          stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                          class="feather feather-plus-circle bs-me-2">
                      <circle cx="12" cy="12" r="10"></circle>
                      <line x1="12" y1="8" x2="12" y2="16"></line>
                      <line x1="8" y1="12" x2="16" y2="12"></line>
                  </svg>
                  #{@add_button_text}
              </a>
            HTML
        end
    end

    def custom_data
        @data.merge({ nested_form_target: "template" })
    end

    def custom_data_action
        if default_action_required
            "click->nested-form#addAssociation #{@add_button_action}"
        else
            @add_button_action
        end
    end
end
  