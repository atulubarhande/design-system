# frozen_string_literal: true

class Contacts::AddedContact::Component < ApplicationViewComponent
    include ApplicationHelper
    attr_reader :contact
    option :contact, default: proc { nil }
    option :id, default: proc { nil }
    option :contact_id, default: proc { nil }

    option :action, default: proc { "all_active" }
    option :visible, default: proc { true }
    
    option :incoming_active, default: proc { true }
    option :outgoing_active, default: proc { true }
    
    option :numbers, default: proc { Array.new }
    
    option :hidden, default: proc { false }
    option :is_new, default: proc { false }
  end
    