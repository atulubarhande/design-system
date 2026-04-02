# frozen_string_literal: true

class Avatar::Component < ApplicationViewComponent
    COLORS = [
        '#1abc9c', '#2ecc71', '#3498db',
        '#9b59b6', '#34495e', '#16a085',
        '#27ae60', '#2980b9', '#8e44ad',
        '#2c3e50', '#f1c40f', '#e67e22',
        '#e74c3c', '#95a5a6', '#f39c12',
        '#d35400', '#c0392b', '#bdc3c7',
        '#7f8c8d'
      ].freeze
    
      option :name, default: proc { "" }
      option :url, default: proc { nil }
      option :classes, default: proc { "" }
    
      def create_two_letter_avatar
        # Ensure the username is not empty
        if @name.nil? || @name.empty?
          return "NA" # Return "NA" for "Not Available" or any other default value you prefer
        end
      
        # Extract the initials from the @name using any symbol or space as a separator
        initials = @name.scan(/\b[a-zA-Z0-9]/).join
      
        # Ensure the result is exactly two characters long
        if initials.length > 2
          initials = initials[0, 2]
        elsif initials.length < 2
          initials += " " * (2 - initials.length)
        end
      
        return initials
      end
    
      def avatar_color
        # Calculate a deterministic color based on initials
        color_index = create_two_letter_avatar.chars.map(&:ord).sum % COLORS.length
        COLORS[color_index]
      end
    
      def render
        render_inline do
          content_tag(:div, style: "background-color: #{avatar_color}; color: white;") do
            create_two_letter_avatar
          end
        end
      end
end
  