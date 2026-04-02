class Sidebar::Component < ApplicationViewComponent
    include DashboardHelper

    option :links, default: proc { Array.new }

end