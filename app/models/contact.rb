class Contact < ApplicationRecord
  attribute :name,      validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   validate: true
  validates :phone, :numericality => true, :length => { :minimum => 10, :maximum => 15 }
end
