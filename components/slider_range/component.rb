class SliderRange::Component < ApplicationViewComponent
    option :min, default: proc { 1 }
    option :max, default: proc { 100 }
    option :start_value, default: proc { nil }
    option :end_value, default: proc { nil }
    option :max_value_name, default: proc { nil }
    option :min_value_name, default: proc { nil }
end