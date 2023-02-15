class Post < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :photo

  validates :photo, {
    presence: true
  }
  
  def get_image_url
    url_for(self.photo)
  end
end
