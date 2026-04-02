# frozen_string_literal: true

class OsUpdateField::Component < ApplicationViewComponent
    option :options, default: proc { [] }
    option :field_type, default: proc { nil }
    option :name, default: proc { nil }
    option :value, default: proc { nil }
    option :description, default: proc { nil }
    option :label, default: proc { nil }
    option :checkbox_id, default: proc { SecureRandom.uuid }
    option :placeholder, default: proc { nil }
    option :min, default: proc { nil }
    option :max, default: proc { nil }
    option :disabled, default: proc { false }
    option :data, default: proc { Hash.new }
    option :has_null_option, default: proc { false }
    option :promt_message, default: proc { I18n.t('common.select_one') }
    option :rows, default: proc { 6 }
    option :cols, default: proc { 6 }
end
  