class Api::V1::RestaurantmenuitemsController < Api::ApiController
  before_action :authenticate
  before_action :set_restaurantmenuitem, only: [:show, :update, :destroy]

  def index
    restaurant = Restaurant.find(params[:restaurant_id])
    if params[:page]
      @restaurantmenuitems = restaurant.restaurantmenuitems.paginate(:page => params[:page], :per_page => 10)
    else
      @restaurantmenuitems = restaurant.restaurantmenuitems
    end
    render json: @restaurantmenuitems
  end

  def show
    render json: @restaurantmenuitem
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    @restaurantmenuitem = restaurant.restaurantmenuitems.create(restaurantmenuitems_params)
    
    respond_to do |format|
      if @restaurantmenuitem.save
        format.json { render json: @restaurantmenuitem, status: :created }
      else
        format.json { render json: @restaurantmenuitem.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @restaurantmenuitem.update_attributes(restaurantmenuitems_params)
        format.json { render json: @restaurantmenuitem, status: :ok }
      else
        format.json { render json: @restaurantmenuitem.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @restaurantmenuitem.destroy
        format.json { render json: { notice: "restaurantmenuitem is successfully destroyed" }, status: :ok }
      else
        format.json { render json: @restaurantmenuitem.errors, status: :unprocessable_entity }
      end
    end  
  end

  private
    
    def set_restaurantmenuitem
      begin
        restaurant = Restaurant.find(params[:restaurant_id])
        @restaurantmenuitem = restaurant.restaurantmenuitems.find(params[:id])
      rescue
        render json: {notice: " restaurantmenuitem not found"}
      end
    end
    
    def restaurantmenuitems_params
      begin
        params.require(:restaurantmenuitem).permit(:name, :description, :category, :tags, :page)
      rescue Exception => e
        params.permit(:name, :description, :category, :tags, :page)
      end
    end
end
