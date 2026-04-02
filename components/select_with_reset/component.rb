# frozen_string_literal: true

class SelectWithReset::Component < ApplicationViewComponent
    option :id, default: proc { SecureRandom.uuid }
    option :list, default: proc { nil }
    option :selected, default: proc { nil }
    option :label, default: proc { nil }
    option :name, default: proc { nil }
    option :data, default: proc { Hash.new }
    option :action, default: proc { nil }
    option :remove_action, default: proc { nil }
    option :promt_message, default: proc { I18n.t('common.select_one') }
    option :has_null_option, default: proc { true }
    option :container_classes, default: proc { "bs-w-100" }
    option :disabled, default: proc { false }
end
  