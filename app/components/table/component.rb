# frozen_string_literal: true

class Table::Component < ApplicationViewComponent
    renders_one :actions
    renders_many :headers
    option :id, default: proc { SecureRandom.uuid }
    option :headers, default: proc { Array.new }
    option :placeholder, default: proc { I18n.t("common.type_to_search") }
    option :is_select_all, default: proc { false }
    option :show_search, default: proc { true }
    option :warning_message, default: proc { nil }
    option :header_classes, default: proc { nil }
    option :classes, default: proc { nil }

    def column_class(header)
      "bs-col-#{header[:col]}" if header[:col].present?
    end
end
  