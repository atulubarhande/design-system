# frozen_string_literal: true

class SearchListComponent < ViewComponent::Base
  renders_one :empty_frame
  
  def initialize(controller: "search", id:, message: I18n.t("common.blank_search_result"), show_empty: true, content_class: nil, max_height: nil, msg_class: 'bs-m-3')
    @controller = controller
    @id = id
    @message  = message
    @show_empty = show_empty
    @content_class = content_class
    @max_height = max_height
    @msg_class = msg_class
  end

end
