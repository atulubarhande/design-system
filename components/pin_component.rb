# frozen_string_literal: true

class PinComponent < ViewComponent::Base
  def initialize(name: nil, action: nil)
    @name   = name
    @action = action
  end
end
