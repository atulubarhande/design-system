class DeviceProfilesListComponent < ViewComponent::Base
  include Turbo::FramesHelper
  include ApplicationHelper
  renders_one :selected_device_profile
  renders_one :table_header


    def initialize(device_profiles:, name:, selected: [], label_name: I18n.t('common.device_profiles'), allowed_profile_types: [], 
                  partial_path: "v3/device_profiles/device_profile", show_publish_version: false, icon_type: "", show_associated_group: true,
                  show_installation_mode: false, show_selected_array: true, enable_group_based_publish: false, app_type: "",  existing_groups_info: nil, existing_user_groups_info: nil,
                  published_agent_info: nil, published_agent_info_show: false, script_agent_show: false, compatible_device_rc: false, show_selected_count: true, show_selected_count_chip: false )
                  
      @device_profiles = filter_device_profiles(device_profiles, allowed_profile_types)
      @name = name
      @selected = selected
      @label_name = label_name
      @partial_path = partial_path
      @show_installation_mode = show_installation_mode
      @show_publish_version = show_publish_version
      @icon_type = icon_type
      @show_associated_group = show_associated_group
      @show_selected_array = show_selected_array
      @enable_group_based_publish = enable_group_based_publish
      @app_type = app_type,
      @existing_groups_info = existing_groups_info
      @existing_user_groups_info = existing_user_groups_info
      @published_agent_info = published_agent_info
      @published_agent_info_show= published_agent_info_show
      @script_agent_show = script_agent_show
      @compatible_device_rc = compatible_device_rc
      @show_selected_count = show_selected_count
      @show_selected_count_chip = show_selected_count_chip
    end

  
    def selected_array
      selected_profiles = if @selected.present?
                            @device_profiles.select { |profile| @selected.map(&:to_i).include?(profile.id.to_i) }
                          else
                            []
                          end
    
      selected_profiles.map(&:id)
   
    end
    

    def disabled
      @device_profiles&.empty?
    end

    def has_device_profiles
      @device_profiles.present?
    end

    def show_selected_count_chip?
      @show_selected_count_chip.to_s == 'true'
    end

    private

    def filter_device_profiles(device_profiles, allowed_profile_types)
      return device_profiles if allowed_profile_types.blank?

      device_profiles.select do |profile|
        allowed_profile_types.include?(profile.type)
      end
    end
  end
  
