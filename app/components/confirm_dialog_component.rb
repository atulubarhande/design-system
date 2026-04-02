class ConfirmDialogComponent < ViewComponent::Base
  attr_reader :url
  attr_reader :method
  attr_reader :is_sf_account
  def initialize(url:, is_destructive: false, current_user:, is_sf_account:, method:, close_modal_id: "", field_name: "password", pin_name: "pin", submit_btn_class: "bs-btn-danger", action: "", cancel_action: "", data: Hash.new)
    @url = url
    @is_destructive = is_destructive
    @current_user = current_user
    @is_sf_account = is_sf_account
    @method = method
    @close_modal_id = close_modal_id
    @field_name = field_name
    @submit_btn_class = submit_btn_class
    @pin_name = pin_name
    @action = action
    @cancel_action = cancel_action
    @data = data
  end

  def close_on_submit
    @close_modal_id.present?
  end 

  def custom_data
    @data.merge({ bs_modal_target: "form" })
  end

end
    