class PrimaryButtonComponent < ViewComponent::Base
  def initialize(variant: "primary", controller: nil, action: nil, id: nil, data:nil, disabled: false, without_children: false, classes: '')
    @variant    = variant
    @controller = controller
    @action     = action
    @id         = id
    @data       = data
    @disabled   = disabled
    @without_children = without_children
    @classes = classes
  end

  def button_variant_class
    variant_classes = {
      "primary" => "bs-btn-primary",
      "outlined" => "bs-btn-outline-primary",
      "outlined-secondary" => "bs-btn-outline-secondary"
    }
    variant_classes[@variant]
  end
end
