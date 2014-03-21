class Truck < ActiveRecord::Base
  has_many :truck_users
  has_many :users, through: :truck_user
end
