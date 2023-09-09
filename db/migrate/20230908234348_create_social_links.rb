class CreateSocialLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :social_links do |t|
      t.string :name
      t.string :url
      t.references :linkable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
