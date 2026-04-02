# frozen_string_literal: true

class Store::Table::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  include ApplicationHelper
  option :title, default: proc { nil }
  option :create_url, default: proc { nil }
  option :create_frame_id, default: proc { nil }
  option :turbo_frame_url, default: proc { nil }
  option :turbo_frame_id, default: proc { nil }
  option :params, default: proc { nil }
  option :readonly, default: proc { false }
end
