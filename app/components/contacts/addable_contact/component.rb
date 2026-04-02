# frozen_string_literal: true

class Contacts::AddableContact::Component < ApplicationViewComponent
    include ApplicationHelper
    attr_reader :contact
    option :contact, default: proc { nil }
    option :hidden, default: proc { false }
  end
    