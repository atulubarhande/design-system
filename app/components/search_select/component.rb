class SearchSelect::Component < ApplicationViewComponent
  renders_one :empty_frame
  renders_one :search_list_empty_frame
  renders_one :list_footer
  renders_one :custom_list
  include ApplicationHelper

  option :id, default: proc { "" }
  option :list, default: proc { [] }
  option :selected_value, default: proc { nil }
  option :name, default: proc { "" }
  option :label_name, default: proc { "" }
  option :id_name, default: proc { "" }
  option :placeholder, default: proc { "" }
  option :list_data, default: proc { {} }
  option :field_data, default: proc { {} }
  option :disabled, default: proc { false }
  option :required, default: proc { false }
  option :container_classes, default: proc { "" }
  option :is_disabled_field_data, default: proc { true }
  option :search_placeholder, default: proc { I18n.t("common.type_to_search") }
  option :empty_message, default: proc { I18n.t("common.blank_search_result") }
  option :is_checkbox, default: proc { false }
  option :auto_close, default: proc { false }
  option :dropdown_data, default: proc { Hash.new }
  option :empty_entries_for, default: proc { "" }
  option :is_list_group, default: proc { false }
  option :checkbox_data, default: proc { {} }
  option :need_truncate, default: proc { true }
  option :width, default: proc { nil }

  def custom_list_data(item)
    @list_data.merge({
      search_target: "item",
      name: is_hash ? item[@label_name] : item,
      value: is_hash ? item[@id_name] : item,
      item: is_hash ? item.to_json : item,
      action: "#{@is_checkbox ? "" : "click->search-select#onSelect"} #{@list_data[:action]}"
    })
  end

  def custom_field_data
    @field_data.merge({
                        search_select_target: "input"
                      })
  end

  def dropdown_data
    @dropdown_data.merge({
                           search_select_target: 'dropdown'
                         })
  end

  def checkbox_data
    @checkbox_data.merge({
                           checkbox_target: "checkbox",
                           select_all_target: "checkbox",
                           search_select_target: "checkbox",
                           action: "checkbox#updateSelectAllState search-select#onCheckboxSelect #{@checkbox_data[:action]}"
                         })
  end

  def is_hash
    @list.any? { |item| item.is_a?(Hash) || (item.is_a?(Object) && !item.is_a?(String)) }
  end

  def selected_item
    return if @selected_value.to_s.empty?
    # add @selected_value.to_i if things are breaking in windows_device_profile (removed to_i to handle the string case in OneIdp Extended Access Policy)
    is_hash ? (@list.find { |item| item[@id_name]&.to_s == @selected_value&.to_s }&.[](@label_name) || @selected_value) : @selected_value
  end

  def format_item_name(item, label_name)
    name = case item
           when String
             item
           when Hash
             item[label_name]&.to_s
           else
             if item.respond_to?(label_name)
               item.public_send(label_name).to_s
             else
               item.to_s
             end
           end
    name.to_s
  end

  def entries_not_found(empty_entries_for)
    case empty_entries_for
    when 'devices'
      {
        image_path: asset_path('v2/bg/ic_buzz@2x.png'),
        not_found_text: t('common.no_devices_found')
      }
    when 'groups'
      {
        image_path: asset_path('v2/bg/icn_devicegroups@2x.png'),
        not_found_text: t('common.no_groups_found')
      }
    when 'workflows'
      {
        image_path: asset_path('v2/icons/ic-workflow@2x.png'),
        not_found_text: t('common.no_workflows_found')
      }
    when 'profiles'
      { 
        image_path: asset_path('v2/icons/workflow/bg/ic_switch_profile_bg@2x.png'),
        not_found_text: t('common.no_profiles_found')
      }
    end
  end

end
