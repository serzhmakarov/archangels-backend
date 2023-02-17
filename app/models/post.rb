class Post < ApplicationRecord
  attribute :photo
  has_one_attached :photo
end
