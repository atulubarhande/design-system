# frozen_string_literal: true

class Typehead::Component < ApplicationViewComponent
  include Turbo::FramesHelper
  option :id, default: proc { SecureRandom.uuid }
  option :name, default: proc { "" }
  option :html_content, default: proc { nil }
  option :has_devices, default: proc { true }
  option :has_users, default: proc { true }
  option :has_groups, default: proc { true }
  option :has_user, default: proc { true }
  option :has_textarea, default: proc { true }
  option :placeholder, default: proc { "" }
  option :data, default: proc { Hash.new }
  option :action, default: proc { "" }
  option :disabled, default: proc { false }
  option :required, default: proc { false }
  option :classes, default: proc { "" }
  option :user_field_options, default: proc { { default: true } }
end
