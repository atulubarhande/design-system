# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  def initialize(id: SecureRandom.uuid, message: nil, flash_type: "notice", redirect_to: nil)
    @id = id
    @message = message
    @flash_type = flash_type
    @redirect_to = redirect_to
  end
end
