class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :short_description, :long_description, :feedback, :date, :created_at, :photo_url

  def photo_url
    if object.photo.attached?
      url_for({ only_path: true}).merge(object.photo)
    end
  end
end