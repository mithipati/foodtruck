class User < ActiveRecord::Base
  has_many :truck_users
  has_many :trucks, through: :truck_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable


  def find_trucks
    # @user.trucks.map do |truck|
    #   if addresses_for(truck.handle)
    #   elsif "Invalid"


    end
  end




end
