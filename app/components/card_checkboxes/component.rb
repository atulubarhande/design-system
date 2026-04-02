class CardCheckboxes::Component < ApplicationViewComponent
    renders_one :custom_label
    option :name, default: proc { nil }
    option :label, default: proc { nil }
    option :data, default: proc { Hash.new }
    option :selected_array, default: proc { [] }
    option :orginal_array, default: proc { ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"] }
    option :wrap_classes, default: proc { "" }
    option :container_classes, default: proc { "" }
    option :label_classes, default: proc { "" }
end
