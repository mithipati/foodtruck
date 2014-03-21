class TrucksController < ApplicationController
  def new
    @truck = Truck.new
  end

  def create
    @truck = Truck.new(truck_params)
    if @truck.save
      redirect_to user_path
    else
      render 'new'
    end
  end


  private
    def truck_params
      params.require(:truck).permit(:handle)
    end

end
