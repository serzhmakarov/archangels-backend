class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
   
	def self.ransackable_attributes(auth_object = nil)
		# super returns an array of all attributes by default.
		# We're using array subtraction to remove any attributes that we don't want to be searchable.
		super(auth_object) - %w(encrypted_password password_reset_token owner)
	end
end
