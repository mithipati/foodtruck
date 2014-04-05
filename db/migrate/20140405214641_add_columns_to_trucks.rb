class AddColumnsToTrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :description, :string
    add_column :trucks, :location, :string
  end
end
