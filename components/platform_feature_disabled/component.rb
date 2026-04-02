# This component intercepts all turbo requests initiated with a button element,
# which are wrapped inside
# with the help of same stimulus controller to handle progress button state
# This component is not meant to be used in a modal as modal has its own progress handling
class PlatformFeatureDisabled::Component < ApplicationViewComponent
  include ApplicationHelper
  include PlatformPlansHelper

  option :feature_flags, default: proc { [] }
  option :current_user, default: proc { nil }
  option :check_all_features, default: proc { false }
  option :classes, default: proc { 'bs-position-absolute' }

  def owner
    current_user.admin_parent
  end

  def check_features_enabled
    if check_all_features
      feature_flags.all? { |feature| owner.user_subscription.send(feature) }
    else
      features_enabled(feature_flags)
    end
  end
end
