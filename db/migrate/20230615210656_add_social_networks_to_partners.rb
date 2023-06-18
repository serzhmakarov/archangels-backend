class AddSocialNetworksToPartners < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :social_networks, :text
  end
end
