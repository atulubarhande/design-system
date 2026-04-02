class Pagination::Component < ApplicationViewComponent

    option :total_pages, default: proc { nil }
    option :current_page, default: proc { nil }
    option :data, default: proc { Hash.new }
    option :scope, default: proc { nil }
    option :views_prefix, default: proc { "templates" }
    option :custom_pagination, default: proc { false }
    option :target_frame, default: proc { nil }
    option :object, default: proc { nil }
    option :css_class, default: proc { nil }
end