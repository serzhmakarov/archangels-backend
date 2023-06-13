class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :date
      t.string :short_description
      t.text :full_description
      t.integer :priority, null: false, default: 0
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
