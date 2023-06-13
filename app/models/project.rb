class Project < ApplicationRecord
  attribute :photo
  has_one_attached :photo
  belongs_to :partner
end
