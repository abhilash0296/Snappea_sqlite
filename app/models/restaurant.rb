class Restaurant < ActiveRecord::Base
  has_many :restaurantmenuitems
end
