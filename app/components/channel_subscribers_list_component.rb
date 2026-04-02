class ChannelSubscribersListComponent  < ViewComponent::Base
  include Turbo::FramesHelper
  renders_one :search_bar
  renders_one :header

    def initialize(frame_id:, paginate_url:, subscribers:, name:, selected: [], partial_path: "v3/devices/search", subscribers_name: nil, subscribers_email: nil, no_subscribers: nil, subscribe_section_tip: nil)
      @frame_id = frame_id
      @paginate_url = paginate_url
      @subscribers = subscribers
      @name = name
      @selected = selected
      @partial_path = partial_path
      @subscribers_name = subscribers_name
      @subscribers_email = subscribers_email
      @no_subscribers = no_subscribers
      @subscribe_section_tip = subscribe_section_tip
    end

    def render?
      @frame_id.present?
    end

    def disabled 
      @subscribers.empty?
    end

    def has_subscribers
      @subscribers.present?
    end 
  end
  