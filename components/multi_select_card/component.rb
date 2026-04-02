class MultiSelectCard::Component < ApplicationViewComponent
  include ApplicationHelper
  renders_one :custom_label

  option :id, default: proc { "" }
  option :list, default: proc { [] }
  option :selected_value, default: proc { [] }
  option :name, default: proc { "" }
  option :label, default: proc { nil }
  option :description, default: proc { nil }
  option :placeholder, default: proc { nil }
  option :data, default: proc { {} }
  option :select_tag_classes, default: proc { "" }
  option :container_class, default: proc { "" }
  option :label_classes, default: proc { "" }
  option :action, default: proc { nil }
  option :target, default: proc { nil }
  option :remove_action, default: proc { nil }
  option :disabled_options, default: proc { [] }
  option :select_all_index, default: proc { nil }
  option :required, default: proc { false }
  option :max_height, default: proc { nil }
  option :width, default: proc { nil }

  def custom_data
    merged_data = @data.merge({
      multi_select_card_target: "item",
      action: "multi-select-card#addItem #{ "multi-select-card#selectAllOptionSelect" if @select_all_index.present? } #{@action}"
    })

    merged_data.merge!(@target) if @target.is_a?(Hash)

    merged_data
  end
end