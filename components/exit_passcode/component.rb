# frozen_string_literal: true

class ExitPasscode::Component < ApplicationViewComponent
    renders_one :custom_label
    option :label, default: proc { nil }
    option :classes, default: proc {""}
    option :passcode_classes, default: proc {"bs-mx-4"}
    option :passcode_symbol, default: proc {"XXXX-XXXX-XXXX-XXXX"}
    option :passcode, default: proc { nil }
end