class DevicesListComponent < ViewComponent::Base
  include Turbo::FramesHelper
  renders_one :search_bar
  renders_one :header
  renders_one :list_header
  renders_one :empty_slot

    def initialize(frame_id:, paginate_url:, devices:, name:, selected: [], partial_path: "v3/devices/search", warning_message: nil, default_message: I18n.t('common.no_devices_selected'), show_selected: true, header_class: "bs-form-check bs-ps-5 bs-pb-2 bs-pt-3 bs-d-flex bs-justify-content-between", search_list_id: nil, total_pages: nil, ug_duplicate_groups: [], dg_duplicate_groups: [], height: nil,
      per_page_name: "page", search_name: "q")
      @frame_id = frame_id
      @paginate_url = paginate_url
      @devices = devices
      @name = name
      @selected = selected
      @ug_duplicate_groups = ug_duplicate_groups
      @dg_duplicate_groups = dg_duplicate_groups
      @partial_path = partial_path
      @warning_message = warning_message
      # @show_selected = show_or_hide_selected
      @height = height
      @default_message = default_message
      @show_selected = show_selected
      @header_class = header_class
      @search_list_id = search_list_id
      @total_pages = total_pages
      @per_page_name = per_page_name
      @search_name = search_name
    end

    def render?
      @frame_id.present?
    end

    def disabled 
      @devices.empty?
    end

    def has_devices
      @devices.present?
    end 

    def has_warning_message
      @warning_message.present?
    end
    
    def selected_array
      selected_profiles = if @selected.present?
                            selected_ids = Array(@selected).map(&:to_i)
                            @devices.select { |device| selected_ids.include?(device.id.to_i) }
                            # @devices.select { |device| @selected.map(&:to_i).include?(device.id.to_i) }
                          else
                            []
                          end
        
      selected_profiles.map(&:id)
    end
    
    def total_pages
      @total_pages.nil? ? @devices&.total_pages : @total_pages
    end
  end
  