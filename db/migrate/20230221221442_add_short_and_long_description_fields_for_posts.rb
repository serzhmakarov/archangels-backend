class AddShortAndLongDescriptionFieldsForPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :description, :text
    add_column :posts, :short_description, :string
    add_column :posts, :long_description, :text
  end
end
