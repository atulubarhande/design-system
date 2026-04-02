# frozen_string_literal: true

class PageHeader::Component < ApplicationViewComponent
  renders_one :actions
  renders_one :custom_title
  renders_one :search_input
  
  option :supporting_text, default: proc { nil }
  option :title, default: proc { nil }
  option :divider, default: proc { true }

  def divider_classes
    return "bs-nav-divider bs-mb-3 bs-pb-3" if @divider
  end
end
