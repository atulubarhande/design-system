# frozen_string_literal: true

class NixRadio::Component < ApplicationViewComponent
  renders_one :custom_label
  
  option :id, default: proc { SecureRandom.uuid }
  option :name, default: proc { nil }
  option :checked, default: proc { false }
  option :label, default: proc { nil }
  option :data, default: proc { Hash.new }
  option :value, default: proc { false }
end