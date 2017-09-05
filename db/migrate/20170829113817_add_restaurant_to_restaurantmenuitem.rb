class AddRestaurantToRestaurantmenuitem < ActiveRecord::Migration
  def change
    add_reference :restaurantmenuitems, :restaurant, index: true, foreign_key: true
  end
end
