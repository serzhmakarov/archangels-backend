class CreatePartners < ActiveRecord::Migration[7.0]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :short_description
      t.text :long_description

      t.timestamps
    end
  end
end
