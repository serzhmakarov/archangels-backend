class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  # Define user roles as an enum
  enum role: { user: 0, admin: 1 }

  # Define user role methods
  def user?
    role == "user"
  end

  def admin?
    role == "admin"
  end

  def make_admin!
    update!(role: "admin")
  end

  # def generate_jwt
  #   JWT.encode({ id: id, exp: 60.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  # end

  # Set up validation for email and password presence
  validates :email, presence: true
  validates :password, presence: true
end
