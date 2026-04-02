# frozen_string_literal: true

class Modal::Component < ApplicationViewComponent
  renders_one :footer
  renders_one :header
  renders_one :footer_actions
  
  option :id, default: proc { SecureRandom.uuid }
  option :divider, default: proc { true }
  option :title, default: proc { nil }
  option :subtitle, default: proc { nil }
end
