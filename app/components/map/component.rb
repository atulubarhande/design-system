class Map::Component < ApplicationViewComponent
    option :center, default: proc { Array.new }
    option :radius, default: proc { Integer }
    option :coordinates, default: proc { Array.new }
    option :geofence_type, default: proc { String } 
    option :is_gmap, default: proc { Boolean } 
    option :height, default: proc { "100%" }
    option :marker, default: proc { Hash.new }
    option :scroll_zoom, default: proc { false }
    option :zoom_control, default: proc { false }
    option :info_text, default: proc { "" }
    # circular, polygonal

    def data
        {
            center: @center,
            radius: @radius,
            coordinates: @coordinates,
            geofence_type: @geofence_type,
            is_gmap: @is_gmap,
            scroll_zoom: @scroll_control,
            zoom_control: @zoom_control,
            marker: @marker,
            info_text: @info_text,
            height: @height,
        }
    end
end