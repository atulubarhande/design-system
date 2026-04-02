class AdvancedBranding::Component < ApplicationViewComponent
    include ApplicationHelper

    option :data_id, default: proc { "ROW-COL-PAGE" }
    option :data_row_position, default: proc { "ROW_POSITION" }
    option :data_column_position, default: proc { "COL_POSITION" }
    option :template_target, default: proc { "deviceFrameTemplate" }
    option :data_dock_cell, default: proc { nil }
    option :dock_bg_color, default: proc { '#2E4053' } # set default dock bg color or pass as option
end
    