class TableComponent < ViewComponent::Base

  renders_one :title
  renders_many :column_headers
  def initialize( headers: [], hide_overflow: false, hoverable: false)
    @headers = headers
    @hide_overflow = hide_overflow
    @hoverable = hoverable
  end
end
