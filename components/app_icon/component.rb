# frozen_string_literal: true

class AppIcon::Component < ApplicationViewComponent
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

    def render?
      url.present?
    end
end
  