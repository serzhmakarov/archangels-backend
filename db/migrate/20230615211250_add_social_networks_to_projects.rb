class AddSocialNetworksToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :social_networks, :text
  end
end
