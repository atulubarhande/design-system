class ModalComponent < ViewComponent::Base
  def initialize(title:, id:, full_screen:nil, scroll: nil, hide_close_button: nil, close_on_submit: true, is_open: false)
    @title = title
    @id = id
    @scroll = scroll
    @full_screen = full_screen
    @hide_close_button = hide_close_button
    @close_on_submit = close_on_submit
    @is_open = is_open
  end

  def render?
    @id.present?
  end
end
  