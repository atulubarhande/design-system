# frozen_string_literal: true

class Bookmark::Component < ApplicationViewComponent
  include ApplicationHelper

  option :classes, default: proc { '' }
  option :data, default: proc { Hash.new }
  option :bookmarks, default: proc { '' }
end
