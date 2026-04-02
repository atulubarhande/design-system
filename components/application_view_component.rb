# Base class for all view components in our project
require 'dry-initializer'
class ApplicationViewComponent < ViewComponent::Base
  include ApplicationHelper
  extend Dry::Initializer
  include Turbo::FramesHelper
end
