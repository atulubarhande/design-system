class RadioGroupComponent < ViewComponent::Base
  attr_reader :classes
  # renders_many :radios
  renders_many :radios, HiddenInputComponent
  
  def initialize(name: nil)
    @name = name
  end
end
  