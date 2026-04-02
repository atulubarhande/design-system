# frozen_string_literal: true

class Bar::Component < ApplicationViewComponent
    option :labels, default: proc { Array.new }
    option :data, default: proc { Array.new }
    option :height, default: proc { "200" }
    option :width, default: proc { "200" }
    option :overrides, default: proc { "" }
    option :plugins, default: proc { '{"legend":{"display":false}}' }
    option :options, default: proc { '{}' }
    option :legends, default: proc { '{}' }
    option :chart_click, default: proc { false }
    option :tab, default: proc { "Consolidated" }
    option :group_id, default: proc { nil }
    option :group_ids, default: proc { nil }
    option :group_name, default: proc { nil }
    option :has_zoom, default: proc { false }
    option :data_url, default: proc { nil }
    option :chart_id, default: proc { nil }
    option :devices_path, default: proc { nil }
    option :security_incident, default: proc { nil }
    option :sim_swap_route, default: proc { nil }

    def dataset
        overrides.is_a?(Array)? %Q("datasets":[{"data": #{@data[0]}, #{@overrides[0]}}, {"data": #{@data[1]}, #{@overrides[1]}}]) : %Q("datasets":[{"data": #{@data}, #{@overrides}}])
    end
end
  