class MultiSelect::Component < ApplicationViewComponent
    include ApplicationHelper

    option :selected_apps
    option :name
  
    def selected_options
      selected_apps if selected_apps.present?
    end
  
    def selected_option_ids
      selected_options&.pluck(:id) || []
    end
  
    def sorted_selected_options
      return selected_options
      # users.select { |user| selected_options.include?(id) } + users.reject { |user| selected_options.include?(id) }
    end
  
    def selected_options_names
      return 'select app from list' if selected_options.blank?
      if selected_options.length == 1
        "#{selected_options.first.name}"
      elsif selected_options.length == 2
        "#{selected_options.first(2).pluck(:name).join(', ')}"
      else
        "#{selected_options.first(2).pluck(:name).join(', ')} &  #{(selected_options.length - 2).to_s} other"
      end
    end
  
  end
  