class Upload < ApplicationRecord
  validates :photo, presence: true
  validates :post_id, presence: true

  mount_uploader :file, PhotoUploader
end
