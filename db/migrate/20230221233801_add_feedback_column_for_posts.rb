class AddFeedbackColumnForPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :feedback, :text
  end
end
