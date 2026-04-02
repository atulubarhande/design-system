# This component intercepts all turbo requests initiated with a button element,
# which are wrapped inside
# with the help of same stimulus controller to handle progress button state
# This component is not meant to be used in a modal as modal has its own progress handling
class ProgressButtonWrapperComponent < ViewComponent::Base
  def initialize() 
  end
end
