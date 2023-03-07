class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: 0, admin: 1 }
  has_secure_password

  def user?
    role == "user"
  end

  def admin?
    role == "admin"
  end

  def make_admin!
    update!(role: 'admin')
  end
end