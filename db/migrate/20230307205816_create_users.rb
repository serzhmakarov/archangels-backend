class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email,           null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.integer :role,           null: false, default: 0

      t.timestamps
    end
  end
end
