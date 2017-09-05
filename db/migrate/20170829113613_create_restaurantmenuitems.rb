class CreateRestaurantmenuitems < ActiveRecord::Migration
  def change
    create_table :restaurantmenuitems do |t|
      t.string :name
      t.string :description
      t.string :category
      t.string :tags

      t.timestamps null: false
    end
  end
end
