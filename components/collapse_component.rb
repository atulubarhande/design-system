class CollapseComponent < ViewComponent::Base
  renders_one :header
  renders_one :panel

    def initialize(id:, title: "", is_open: false, parent_id:)
      @id = id
      @title = title
      @is_open = is_open
      @parent_id = parent_id
    end

  end
  