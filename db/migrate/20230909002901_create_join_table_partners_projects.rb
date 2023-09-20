class CreateJoinTablePartnersProjects < ActiveRecord::Migration[7.0]
  def change
    create_join_table :partners, :projects do |t|
      t.index [:project_id, :partner_id], unique: true
      t.index [:partner_id, :project_id]
    end
  end
end
