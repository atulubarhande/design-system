class CustomTableComponent < ViewComponent::Base
    renders_many :headers
    renders_one :tableBody
    def initialize()
    end
end
  