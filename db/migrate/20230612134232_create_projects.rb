class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :date
      t.string :short_description
      t.text :long_description
      t.decimal :foundation_amount, precision: 10, scale: 2
      t.string :status
      t.integer :priority, null: false, default: 0

      t.timestamps
    end

    add_index :projects, :priority, unique: true
  end
end
