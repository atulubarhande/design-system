# frozen_string_literal: true

class TabComponent < ViewComponent::Base
  def initialize(type: 'border', height: nil) 
    @type   = type
    @height = height
  end

  renders_many :tabs
  renders_many :panels
end
