# frozen_string_literal: true

class DragDropCsv::Component < ApplicationViewComponent
  include ApplicationHelper
  include Turbo::FramesHelper
  renders_one :sample_button
  renders_many :input_fields
  renders_one :hidden_input
  renders_one :upload_area
  
  option :form_url, default: proc { nil }
  option :action, default: proc { nil }
  option :auto_start_status_check, default: proc { false }
  option :frame_id, default: proc { nil }
  option :modal_id, default: proc { nil }
  option :text, default: proc { nil }
  option :upload_csv, default: proc { true }
  option :name, default: proc { "file" }
  option :file_type, default: proc { ".csv" }
  option :is_s3_upload, default: proc { false }
  option :upload_csv_text, default: proc { I18n.t("v2.bulk_enrollment.csv_drop_or_select") }
  option :file_size_error, default: proc { I18n.t("v2.bulk_enrollment.file_size_error") }
  option :max_file_size, default: proc { nil }
end
  