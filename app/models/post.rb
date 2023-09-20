class Post < ApplicationRecord
  attribute :photo
  has_one_attached :photo

  def thumbnail
    photo.variant(resize: "50x50!") if photo.attached?
  end
end
