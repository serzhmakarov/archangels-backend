class Contact < ApplicationRecord
  attribute :name,      validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   validate: true
  attribute :phone

  validates :phone, presence: true, format: { with: /\A\+?\d{10,14}\z/, message: "must be a valid phone number" }
end
