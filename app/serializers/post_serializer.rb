class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :description, :date, :name

  # def featured_image
  #   if object.photo.attached?
  #     {
  #       url: rails_blob_url(object.photo)
  #     }
  #   end
  # end
end
