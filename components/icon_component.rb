# frozen_string_literal: true
class IconComponent < ViewComponent::Base

  def initialize(src: nil,bg_class: "tw-bg-gray-400", auto_height: nil)
    @src = src
    @bg_class    = bg_class
    @auto_height = auto_height
  end
end
  