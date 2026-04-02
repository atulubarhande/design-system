# frozen_string_literal: true

class StepsToEnroll::Component < ApplicationViewComponent
    option :steps, default: proc { Array.new }
    option :classes, default: proc { "bs-ps-3" }
end
  