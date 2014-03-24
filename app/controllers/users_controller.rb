class UsersController < ApplicationController
include ApplicationHelper
  before_filter :authenticate_user!

  def index
    redirect_to current_user
  end

  def show
    @user = User.find(params[:id])
    @truck = Truck.new
    @response = uni_get

  end

end
