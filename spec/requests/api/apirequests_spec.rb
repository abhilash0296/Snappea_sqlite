require 'rails_helper'

describe "Snappea API " do
  
  it 'should test user apis' do    
    #create
    post "/users" , user: {:name => "TestUser", :email => "TestUser@testmail.com", :password => "12345678" } , format: 'json'
    new_user_json = JSON.parse(response.body)
    expect(response).to have_http_status(:created)
    expect(new_user_json['notice']).to eq("user is successfully created")
    
    #login successfull
    post "/users/login" , user: { :email => "TestUser@testmail.com", :password => "12345678" } , format: 'json'
    authenticated_user_json = JSON.parse(response.body)
    expect(response).to have_http_status(:ok)
    expect(authenticated_user_json['token'].length).to eq(32)

    #login unsuccessfull
    post "/users/login" , user: { :email => "TestUser@testmail.com", :password => "fakepassword" } , format: 'json'
    unauthenticated_user_json = JSON.parse(response.body)
    expect(unauthenticated_user_json['notice']).to eq("Invalid Credentials")    
    
    # retrieve 
    get "/users"
    json = JSON.parse(response.body)
    expect(json.first['email']).to eq("TestUser@testmail.com")
    
    get "/users/#{json.first['id']}"
    json = JSON.parse(response.body)
    expect(json['name']).to eq("TestUser")
    
    #update
    put "/users/#{json['id']}" , user: {:name => "UpdatedTestUser", :email => "TestUser@testmail.com", :password => "12345678" } , format: 'json'  
    updated_user_json = JSON.parse(response.body)    
    expect(response).to have_http_status(:ok)
    expect(updated_user_json['notice']).to eq("user is successfully updated")
    
    #Destroy
    delete "/users/#{json['id']}" , format: 'json'  
    json = JSON.parse(response.body)
    expect(response).to have_http_status(:ok)
    expect(json['notice']).to eq("user is successfully destroyed")
    
    
    
  end
  
  it 'should test restaurant apis' do
    #create token
    post "/users" , user: {:name => "TestUser", :email => "TestUser@testmail.com", :password => "12345678" } , format: 'json'
    post "/users/login" , user: { :email => "TestUser@testmail.com", :password => "12345678" } , format: 'json'
    authenticated_user_json = JSON.parse(response.body)    
    token = authenticated_user_json['token']
    
    #restaurant should not be able to access without token
    get "/api/v1/restaurants"
    expect(response).to have_http_status(:unauthorized)    
    
    #create restaurant
    post "/api/v1/restaurants" , { restaurant: {:name => "TestRestaurant", :description => "veg", :rating => "0.4", :address => "TestAddress" }}, { Authorization:  "Token token=#{token}"}
    new_restaurant_json = JSON.parse(response.body)    
    expect(response).to have_http_status(:created)    
    expect(new_restaurant_json['name']).to eq("TestRestaurant")
    
    #read restaurant
    get "/api/v1/restaurants/#{new_restaurant_json['id']}", {}, { Authorization:  "Token token=#{token}"}
    expect(new_restaurant_json['name']).to eq("TestRestaurant")
    
    #update restaurant
    put "/api/v1/restaurants/#{new_restaurant_json['id']}" , { restaurant: {:name => "TestUpdateRestaurant", :description => "veg", :rating => "0.4", :address => "TestUpdateAddress" }}, { Authorization:  "Token token=#{token}"}
    update_restaurant_json = JSON.parse(response.body)
    expect(response).to have_http_status(:ok)
    expect(update_restaurant_json['name']).to eq("TestUpdateRestaurant")
    expect(update_restaurant_json['address']).to eq("TestUpdateAddress")
    
    #destroy restaurant
    delete "/api/v1/restaurants/#{new_restaurant_json['id']}" , {}, { Authorization:  "Token token=#{token}"}
    json = JSON.parse(response.body)
    expect(response).to have_http_status(:ok)
    expect(json['notice']).to eq("restaurant is successfully destroyed")  
      
  end
  
  it 'should test restaurant apis' do
    #create token
    post "/users" , user: {:name => "TestUser", :email => "TestUser@testmail.com", :password => "12345678" } , format: 'json'
    post "/users/login" , user: { :email => "TestUser@testmail.com", :password => "12345678" } , format: 'json'
    authenticated_user_json = JSON.parse(response.body)    
    token = authenticated_user_json['token']
    
    #create Restaurant
    post "/api/v1/restaurants" , { restaurant: {:name => "TestRestaurant", :description => "TestDescription", :rating => "0.4", :address => "TestAddress" }}, { Authorization:  "Token token=#{token}"}
    restaurant_json = JSON.parse(response.body)
    restaurant_id = restaurant_json['id']
    
    #restaurant should not be able to access without token
    get "/api/v1/restaurants/#{restaurant_id}/restaurantmenuitems"
    expect(response).to have_http_status(:unauthorized)
        
    #create restaurant_menu_item
    post "/api/v1/restaurants/#{restaurant_id}/restaurantmenuitems" , { restaurantmenuitem: {:name => "TestRestaurantMenuItem", :description => "TestRestaurantMenuItemDescription", :category => "side", :tags => "TestRestaurantMenuItemTag" }}, { Authorization:  "Token token=#{token}"}
    new_restaurantmenuitem_json = JSON.parse(response.body)
    expect(response).to have_http_status(:created)
    expect(new_restaurantmenuitem_json['name']).to eq("TestRestaurantMenuItem")

    #read restaurant
    get "/api/v1/restaurants/#{restaurant_id}/restaurantmenuitems/#{new_restaurantmenuitem_json['id']}", {}, { Authorization:  "Token token=#{token}"}
    expect(new_restaurantmenuitem_json['name']).to eq("TestRestaurantMenuItem")

    #update restaurant
    put "/api/v1/restaurants/#{restaurant_id}/restaurantmenuitems/#{new_restaurantmenuitem_json['id']}" , { restaurantmenuitem: {:name => "TestRestaurantMenuItemUpdate", :description => "TestRestaurantMenuItemDescriptionUpdate", :category => "side", :tags => "TestRestaurantMenuItemTagUpdate" }}, { Authorization:  "Token token=#{token}"}
    update_restaurantmenuitem_json = JSON.parse(response.body)
    expect(response).to have_http_status(:ok)
    expect(update_restaurantmenuitem_json['name']).to eq("TestRestaurantMenuItemUpdate")
    expect(update_restaurantmenuitem_json['description']).to eq("TestRestaurantMenuItemDescriptionUpdate")

    #destroy restaurant
    delete "/api/v1/restaurants/#{restaurant_id}/restaurantmenuitems/#{new_restaurantmenuitem_json['id']}" , {}, { Authorization:  "Token token=#{token}"}
    json = JSON.parse(response.body)
    expect(response).to have_http_status(:ok)
    expect(json['notice']).to eq("restaurantmenuitem is successfully destroyed")

  end
  
end
