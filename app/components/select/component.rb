# frozen_string_literal: true

class Select::Component < ApplicationViewComponent
    renders_one :custom_label
    option :name, default: proc { nil }
    option :label, default: proc { nil }

    option :data, default: proc { Hash.new }
    option :list, default: proc { [] }
    option :selected, default: proc { nil }
    option :classes, default: proc { nil }
    option :has_null_option, default: proc { true }
    option :required, default: proc { false }
    option :disabled, default: proc { false }
    option :promt_message, default: proc { I18n.t('common.select_one') }
    option :id, default: proc { nil }
    option :disabled_options, default: proc { [] }
    option :multiple, default: proc { false }
    option :description, default: proc { nil }
    option :label_size, default: proc { 6 }
    option :container_classes, default: proc { nil }
    option :disable_prompt, default: proc { false }
    option :label_classes, default: proc { "bs-text-nowrap" }


    # def label_classes
    #     _classes = `%w(bs-form-label bs-fs-6 bs-text-body-secondary bs-my-3 #{@label_class})`
    # end

    # Only set id if provided, rails will set it otherwise using name attr
    def set_id 
        id_hash = {}
        id_hash = id_hash.merge({ :id => @id }) if @id.present?
        id_hash
    end

    def custom_data
        @data.merge({ controller: "select", select_disable_prompt_value: @has_null_option && @disable_prompt})
    end
end
  