class BsModalSubmitButtonComponent < ViewComponent::Base
  def initialize(action: nil, classes: "bs-btn bs-btn-primary", data: Hash.new, disabled: false, is_disabled_loading: false, id: nil, submit_form: true)
    @action = action
    @classes = classes
    @data = data
    @disabled = disabled
    @is_disabled_loading = is_disabled_loading
    @id = id
    @submit_form = submit_form
  end

  def custom_data
    if @submit_form
      if @is_disabled_loading
        @data.merge({ action: "#{@action} modal-form#submitModalForm" })
      else
        @data.merge({ action: "#{@action} modal-form#submitModalForm", bs_modal_target: "saveButton", turbo_modal_target: "saveButton" })
      end
    else
      @data.merge({ action: "#{@action}" })
    end
  end 
end
