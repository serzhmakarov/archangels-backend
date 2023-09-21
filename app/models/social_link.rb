class SocialLink < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  def self.ransackable_attributes(auth_object = nil)
    # super returns an array of all attributes by default.
    # We're using array subtraction to remove any attributes that we don't want to be searchable.
    super(auth_object) - %w(logo encrypted_password password_reset_token owner)
  end
end
