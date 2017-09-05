class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :description
      t.float :rating
      t.string :address

      t.timestamps null: false
    end
  end
end
