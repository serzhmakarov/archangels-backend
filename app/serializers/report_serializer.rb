class ReportSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :description, :date
  # def featured_image
  #   if object.photo.attached?
  #     {
  #       url: rails_blob_url(object.photo)
  #     }
  #   end
  # end
end
