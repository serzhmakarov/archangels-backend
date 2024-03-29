class PartnerSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :short_description, :full_description, :created_at, :photo_url, :projects_count, :projects, :social_links
  has_many :projects

  def photo_url
    url_for(object.photo) if object.photo.attached?
  end

  def projects_count
    object.projects.count
  end

  def projects
    instance_options[:show_projects] ? object.projects : []
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