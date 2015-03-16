class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    # Google needs a URL-escaped address for its location
    @url_escaped_addr = @restaurant.address.gsub(/ /, '+')

    @googlemap = @restaurant.googlemaps_url(@url_escaped_addr, @restaurant)

  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = 'Your restaurant was created'
      redirect_to @restaurant
    else
      render action: 'new'
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(restaurant_params)
      flash[:notice] = 'Your restaurant was updated'
      redirect_to @restaurant
    else
      render action: 'edit'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to root_path
  end

  def delete
    @restaurant = Restaurant.find(params[:id])
    @restaurant.delete
    redirect_to root_path
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:id, :name, :address, :phone, :description)
    end

end
