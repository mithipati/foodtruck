class TrucksController < ApplicationController
  before_action :set_instance_variables, only: [:create]


  def create
    @truck = @user.trucks.create(truck_params)
    if @truck.valid?
      redirect_to @user
    else
      redirect_to root_path
    end
  end


  private
    def set_instance_variables
      @user = User.find(params[:user_id])
    end

    def truck_params
      params.require(:truck).permit(:handle, :user_id, :truck_id, :description, :location)
    end

end
