class ProjectSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :short_description, :long_description, 
  :date, :photo_url, :priority, :social_networks
  belongs_to :partner

  def photo_url
    url_for(object.photo) if object.photo.attached?
  end

  def social_networks
    if object.social_networks?
      eval(object.social_networks)
    end
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