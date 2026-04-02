class SearchComponent < ApplicationViewComponent
    option :url, default: proc { nil }
    option :name, default: proc { nil }
    option :placeholder, default: proc { I18n.t("common.type_to_search") }
    option :target_frame, default: proc { "" }
    option :container_classes, default: proc { "bs-me-3" }
    option :data, default: proc { Hash.new }
    option :input_data, default: proc { Hash[{action: "form-submission#search"}] }
    option :form_class, default: proc { nil }
    option :method, default: proc { :get }
    option :id, default: proc { nil }

    def data_attr
      @data.merge({ turbo_stream: "", turbo_frame: @target_frame, controller: 'form-submission', form_submission_target: "form"})
    end

  end
  