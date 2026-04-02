# frozen_string_literal: true

class ClientNotificationComponent < ViewComponent::Base
  def initialize(message: nil)
    @message = message
  end
end
