class Api::V1::RestaurantsController < Api::ApiController
  before_action :authenticate
  before_action :set_restaurant, only: [:show, :update, :destroy]

  def index
    if params[:page]
      @restaurants = Restaurant.paginate(:page => params[:page], :per_page => 10)
    else
      @restaurants = Restaurant.all
    end
    render json: @restaurants
  end

  def show
    render json: @restaurant
  end
  
  def create    
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.json { render json: @restaurant, status: :created }
      else
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.json { render json: @restaurant, status: :ok }
      else
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    respond_to do |format|
      if @restaurant.destroy
        format.json { render json: { notice: "restaurant is successfully destroyed" }, status: :ok }
      else
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  def set_restaurant
    begin
      @restaurant = Restaurant.find(params[:id])
    rescue
      render json: {notice: " restaurant not found"}
    end
  end
  
  def restaurant_params
    begin
      params.require(:restaurant).permit(:name, :description, :rating, :address , :page)
    rescue Exception => e
      params.permit(:name, :description, :rating, :address , :page)
    end
  end
  
end
