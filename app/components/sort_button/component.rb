# frozen_string_literal: true

class SortButton::Component < ApplicationViewComponent
  option :title, default: proc { nil }
  option :url, default: proc { nil }
  option :order_by, default: proc { nil }
  option :turbo_frame_id, default: proc { nil }

  # Only reverse sorting for active/applied button
  def sorting
    params[:order_by] == @order_by && params[:sorting] == "desc" ? "asc" : "desc"
  end
end
  