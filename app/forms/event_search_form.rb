class EventSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string

  def search
    Event.search(
      keyword_for_search,
      where: { start_at: { gt: start_at } },
    )
  end

  def start_at
    @start_at || Time.current
  end

  def start_at=(new_start_at)
    @start_at = new_start_at.in_time_zone
  end

  private

  def keyword_for_search
    keyword.presence || "*"
  end
end
