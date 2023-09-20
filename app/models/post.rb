class Post < ApplicationRecord
  attribute :photo
  has_one_attached :photo
  has_many :social_links, as: :linkable
  accepts_nested_attributes_for :social_links, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    # super returns an array of all attributes by default.
    # We're using array subtraction to remove any attributes that we don't want to be searchable.
    super(auth_object) - %w(encrypted_password password_reset_token owner)
  end

  def thumbnail
    photo.variant(resize: "50x50!") if photo.attached?
  end
end
