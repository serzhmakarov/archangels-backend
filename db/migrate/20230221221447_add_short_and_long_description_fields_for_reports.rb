class AddShortAndLongDescriptionFieldsForReports < ActiveRecord::Migration[7.0]
  def change
    remove_column :reports, :description, :text
    add_column :reports, :short_description, :string
    add_column :reports, :long_description, :text
  end
end
