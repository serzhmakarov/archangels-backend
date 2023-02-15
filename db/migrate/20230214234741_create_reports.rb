class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :name
      t.text :description
      t.datetime :date
      t.text :photo
      
      t.timestamps
    end
  end
end
