# frozen_string_literal: true

class Doughnut::Component < ApplicationViewComponent
    option :labels, default: proc { Array.new }
    option :data, default: proc { Array.new }
    option :height, default: proc { "200" }
    option :width, default: proc { "200" }
    option :overrides, default: proc { "" }
    option :plugins, default: proc { '{"legend":{"display":false}}' }
    option :options, default: proc { '{}' }
    option :chart_click, default: proc { false }
    option :data_url, default: proc { nil }
    option :tab, default: proc { "Consolidated" }
    option :group_id, default: proc { nil }
    option :group_ids, default: proc { nil }
    option :group_name, default: proc { nil }
    option :show_legend, default: proc { false }
    option :custom_tooltip, default: proc { false }
    option :storage_tooltip, default: proc { false }
    option :used_value, default: proc { nil }
    option :available_value, default: proc { nil }
    option :chart_type, default: proc { "doughnut" }
    option :device_storage, default: proc { false }
    option :devices_path, default: proc { nil }
end
  