class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    # Google needs a URL-escaped address for its location
    @url_escaped_addr = @restaurant.address.gsub(/ /, '+')

    @googlemap = googlemaps_url(@url_escaped_addr, @restaurant)

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

  def googlemaps_url(escaped_address, venue)
    mapwidth = 250
    mapheight = 250
    zoomlevel = 14
    center = escaped_address
    markertitle = venue.name.gsub(/ /, '+')
    markercenter = escaped_address
    markersize = "mid"
    maptype = "roadmap"
    regular_url = ("https://maps.googleapis.com/maps/api/staticmap?center=" + escaped_address +
    "&zoom=" + zoomlevel.to_s +
    "&size=" + mapwidth.to_s + "x" + mapheight.to_s +
    "&maptype=roadmap" +
    "&markers=size:mid%7Ccolor:red%7Clabel:A%7C" + escaped_address
    )
    return (regular_url)
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:id, :name, :address, :phone, :description)
    end

end
