class TrucksController < ApplicationController
  def new
    @truck = Truck.new
  end

  def create
    @truck = Truck.new(truck_params)
    if @truck.save
      redirect_to current_user
    else
      redirect_to current_user
    end
  end


  private
    def truck_params
      params.require(:truck).permit(:handle)
    end

end
