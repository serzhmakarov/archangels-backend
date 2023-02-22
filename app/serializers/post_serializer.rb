class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :short_description, :long_description, :feedback, :date, :created_at, :photo_url

  def photo_url
    url_for(object.photo) if object.photo.attached?
  end
end