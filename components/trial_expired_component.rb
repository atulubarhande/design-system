class TrialExpiredComponent < ViewComponent::Base
    def initialize(licences:, user:, owner:, licence_count:)
        @licences = licences
        @user = user
        @owner = owner
        @licence_count = licence_count
    end
end 

def render?
    (owner.hide_pricing? || owner.regional_reseller&.active?.present?) && licence_count
end 