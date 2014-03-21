class CreateTruckUsers < ActiveRecord::Migration
  def change
    create_table :truck_users do |t|
      t.references :user, index: true
      t.references :truck, index: true

      t.timestamps
    end
  end
end
