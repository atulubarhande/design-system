# frozen_string_literal: true

class RefreshOnSubmit::Component < ApplicationViewComponent
    option :frame_id, default: proc { nil }
    option :src, default: proc { nil }
    option :refresh, default: proc { true }

    def render?
        @frame_id.present?
    end
end
  