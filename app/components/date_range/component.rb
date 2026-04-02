class DateRange::Component < ApplicationViewComponent
    option :id, default: proc { "date_range_select" }
    option :start_date, default: proc { Date.today - 7.days }
    option :end_date, default: proc { Date.today }
    option :max_date, default: proc { Date.today }
    option :max_range, default: proc { 0 } #in Days
    option :start_date_name, default: proc { "start_date" }
    option :end_date_name, default: proc { "end_date" }
    option :placeholder, default: proc { nil }
    option :action, default: proc { "" }
    option :id, default: proc { "selected_date_range" }
    option :custom_event, default: proc { "dateRangeSelected" }
end
