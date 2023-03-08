class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :short_description, :long_description, :feedback, :date, :created_at, :photo_url

  def photo_url
    url_for(object.photo) if object.photo.attached?
  end

  # Add pagination links to the response
  def meta
    {
      total_pages: object.total_pages,
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page,
      total_count: object.total_count
    }
  end
end