# Server side rendered modal
# requires to have a wrapper controller "turbo-modal"
# Which listenes to turbo events
class TurboModalComponent < ViewComponent::Base
  include Turbo::FramesHelper
  renders_one :header
  renders_one :footer
  renders_one :modal_content

    def initialize(id:,
      turbo_frame_id: nil,
      title: nil,
      close_on_submit: true,
      size: "",
      show_dismiss_btn: true,
      height: nil,
      show_header: true,
      classes: "",
      scroll: true,
      show_cancel_button: false,
      modal_body_class: "bs-px-4",
      backdrop: "static",
      is_destructive_action: false,
      turbo_submit: nil,
      hide_modal_form_ids: [],
      keyboard: true,
      title_class: 'bs-text-body',
      footer_classes: 'bs-modal-footer bs-border-0 bs-flex-column bs-flex-sm-row bs-p-4',
      handle_modal_close: '',
      modal_hide_statuses: [ 200 ] )
      @id = id
      @turbo_frame_id = turbo_frame_id
      @title = title
      @size = size
      @show_dismiss_btn = show_dismiss_btn
      @close_on_submit = close_on_submit
      @height = height
      @show_header = show_header
      @classes = classes
      @scroll = scroll
      @show_cancel_button = show_cancel_button
      @modal_body_class = modal_body_class
      @backdrop = backdrop
      @is_destructive_action = is_destructive_action
      @turbo_submit = turbo_submit
      @hide_modal_form_ids = hide_modal_form_ids
      @keyboard = keyboard
      @title_class = title_class
      @footer_classes = footer_classes
      @handle_modal_close = handle_modal_close
      @modal_hide_statuses = modal_hide_statuses
    end

  def render?
    @id.present?
  end
end
