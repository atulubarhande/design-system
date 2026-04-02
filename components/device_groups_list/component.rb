# frozen_string_literal: true

class DeviceGroupsList::Component < ApplicationViewComponent
    include Turbo::FramesHelper
    include ApplicationHelper
    renders_one :search_bar
    renders_one :header
    renders_one :selected_list
    renders_one :radio_buttons
    
    option :id, default: proc { "output-groups-search" }
    option :frame_id, default: proc { nil }
    option :row_class, default: proc { nil }
    option :select_multiple, default: proc { false }
    option :search_param_name, default: proc { "q" }
    option :action, default: proc { nil } # action subscribed by parent controller if any
    option :has_user_groups, default: proc { false } # action subscribed by parent controller if any

    option :items, default: proc { Hash.new }
    option :hide_empty_groups_on_load, default: proc { false }
    option :name, default: proc { nil }
    option :selected, default: proc { Array.new }
    option :partial_path, default: proc { nil }
    option :byod_device, default: proc { false }
    option :refresh_same_frame, default: proc { false }
    option :show_org_units, default: proc { false }
    option :show_devices, default: proc { false }
    option :app_show_devices_label, default: proc{ false }
    option :show_version_label, default: proc{ true }

    def render?
        @frame_id.present?
    end

    def disabled 
        !@select_multiple
    end
end
  