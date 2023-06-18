class AddSocialNetworksToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :social_networks, :text
  end
end
