# frozen_string_literal: true

class Label::Component < ApplicationViewComponent
    renders_one :custom_label
    renders_one :other_logo

    option :id, default: proc { SecureRandom.uuid }
    option :name, default: proc { nil }
    option :label, default: proc { nil }
    option :description, default: proc { nil }
    option :classes, default: proc { "" }
    option :platform_logo, default: proc { nil }
    option :platform_height, default: proc { nil }
    option :line_break, default: proc { true }
    option :asterisk, default: proc { false }
    option :show_upgrade_plan, default: proc { false }
    option :current_user, default: proc { nil }
    option :upgrade_plan_classes, default: proc {'bs-ps-3'}
    option :description_classes, default: proc { "bs-text-body-secondary bs-fs-6" }
    option :data, default: proc { Hash.new }
    option :title, default: proc { nil }
end