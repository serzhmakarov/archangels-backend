class Partner < ApplicationRecord
  has_many :projects
  attribute :photo
  has_one_attached :photo
end
