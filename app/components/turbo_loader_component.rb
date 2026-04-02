class TurboLoaderComponent < ViewComponent::Base
    def initialize(id: SecureRandom.uuid)
        @id = id
    end
end 
