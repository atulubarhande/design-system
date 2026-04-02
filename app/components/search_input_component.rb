class SearchInputComponent < ViewComponent::Base
    def initialize(id:, controller: "search-input", action: "search-input#findAndApply", placeholder: I18n.t("common.type_to_search"), classes: nil, data: Hash.new, type: "text", container_classes: "")
      @action = action
      @controller = controller
      @id = id
      @placeholder = placeholder
      @classes = classes
      @data = data
      @type = type
      @container_classes = container_classes
    end
    
    def data 
      @data.merge({ search_input_target_value: @id, controller: @controller, action: @action })
    end
  end
  