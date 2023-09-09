class CreateJoinTablePartnersProjects < ActiveRecord::Migration[7.0]
  def change
    create_join_table :partners, :projects do |t|
      # t.index [:partner_id, :project_id]
      # t.index [:project_id, :partner_id]
    end
  end
end
