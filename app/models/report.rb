class Report < ApplicationRecord
  attribute :photo
  has_one_attached :photo
end
