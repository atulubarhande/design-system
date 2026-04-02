# frozen_string_literal: true

class Store::Permissions::Component < ApplicationViewComponent
  include ApplicationHelper
  option :permissions, default: proc { Hash.new }
end
  