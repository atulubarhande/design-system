# frozen_string_literal: true

class DeviceProfileListComponent < ViewComponent::Base
  with_collection_parameter :item

  def initialize(item:, notice:, title:, type:)
    @item = item
    @title = title
    @type = type
    @notice = notice
  end

end
