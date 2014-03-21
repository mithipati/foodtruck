class CreateTrucks < ActiveRecord::Migration
  def change
    create_table :trucks do |t|
      t.string :handle

      t.timestamps
    end
    add_index :trucks, :handle
  end
end
