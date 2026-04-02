class BsModalComponent < ViewComponent::Base
  include Turbo::FramesHelper
  # This modal will be destroyed after successful form submission, unless close_on_submit is set to false
  renders_one :footer
  renders_one :header
  renders_one :title
  renders_one :dismiss_button

    def initialize(id:, title:, close_on_submit: true, size: "", show_dismiss_btn: true, classes: nil, height: nil, current_user: nil, 
                  scroll: true, show_header: true, show_cancel_button: false, is_destructive_action: false, extra_controller: '', 
                  backdrop: "static", modal_body_class: "bs-px-4", add_backdrop: false, trigger_on: nil, custom_modal_height: nil, on_close_action: nil)
      @id = id
      @title = title
      @size = size
      @show_dismiss_btn = show_dismiss_btn
      @close_on_submit = close_on_submit
      @classes = classes
      @height = height
      @current_user = current_user
      @scroll = scroll
      @show_header = show_header
      @extra_controller = extra_controller
      @show_cancel_button = show_cancel_button
      @is_destructive_action = is_destructive_action
      @backdrop = backdrop
      @modal_body_class = modal_body_class
      @add_backdrop = add_backdrop
      @trigger_on = trigger_on
      @custom_modal_height = custom_modal_height
      @on_close_action = on_close_action
    end

    def render?
      @id.present?
    end
  end
  