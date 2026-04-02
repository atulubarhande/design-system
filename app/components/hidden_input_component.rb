class HiddenInputComponent < ViewComponent::Base
    def initialize(value:, name:)
        @value = value
        @name = name
    end
  end
    