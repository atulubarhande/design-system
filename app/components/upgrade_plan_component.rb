class UpgradePlanComponent < ViewComponent::Base
  include Turbo::FramesHelper
  include ApplicationHelper
  renders_one :card, CardComponent
  renders_one :list_item, ListItemComponent
  renders_one :dropdown, BsDropdownComponent
  renders_one :modal, BsModalComponent
  renders_one :button

  def initialize(current_user: , centered_element: true, label_text: 'feature', classes: nil, upgrade_plan_button_classes: nil, icon_classes: nil, min_width: "277px")
    @current_user = current_user
    @centered_element = centered_element # by default creating centered button element
    @label_text = label_text
    @classes = classes
    @upgrade_plan_button_classes = upgrade_plan_button_classes
    @icon_classes = icon_classes
    @min_width = min_width
  end

end
