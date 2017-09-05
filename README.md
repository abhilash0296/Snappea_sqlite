# Snappea

# Steps to install and run the project

* prerequisite:
  1. Ruby 2.3
  2. Rails 4.2

1. Clone the project
2. Change directory to project directory
3. run $ Rake db:create
4. run $ budle install
5. run $ rails s

* Rails server will start successfully.


# Rspec Test cases :-

1. Change directory to project directory
2. run $ rspec spec/requests/api/apirequests_spec.rb


# Rest Api Calls (for localhost) :-

* If need to test on production, then change host in urls. Try some Curl Calls as follows

1) User :- 

1. List All Users = curl http://localhost:3000/users
2. Create new User Record = curl -X POST -d "name=test1&email=test1@testmail.com&password=12345678" http://localhost:3000/users
3. Show special User with userId = curl http://localhost:3000/users/1
4. Authenticate User using username and password = curl -X POST -d "email=test1@testmail.com&password=12345678" http://localhost:3000/users/login
 * (This above Authentication call will return token, use it in Restaurant and Restaurantmenuitem rest api calls)
5. Update User Record = curl -X PUT -d "name=testuser2&email=testuser2@testmail.com&password=12345678" http://localhost:3000/users/1
6. Destroy Restaurant Record = curl -X DELETE http://localhost:3000/users/1


2) Restaurants :- 

* You can find token user autentication call. Replace 'testtoken' with the token value in below requests. 

1. List All Restaurant = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants
2. List All Restaurant WITH PAGINATION = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants?page=1
3. Create new Restaurant Record = curl -H "Authorization: Token token=testtoken" -X POST -d "name=testR1&description=testD1&rating=0.4&address=testA1" http://localhost:3000/api/v1/restaurants
4. Create new Restaurant Record for use in restaurantmenuitems api calls = curl -H "Authorization: Token token=testtoken" -X POST -d "name=testR3&description=testD3&rating=0.4&address=testA3" http://localhost:3000/api/v1/restaurants
5. Show Restaurant with RestaurentId = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants/1
6. Update Restaurant Record = curl -H "Authorization: Token token=testtoken" -X PUT -d "name=testR2&description=testD2&rating=0.4&address=testA2" http://localhost:3000/api/v1/restaurants/1
7. Destroy Restaurant Record = curl -H "Authorization: Token token=testtoken" -X DELETE http://localhost:3000/api/v1/restaurants/1


3) Restaurant menu items :- 

* You can find token user autentication call. Replace 'testtoken' with the token value in below requests. 

1. List All Restaurantmenuitems = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems
2. List All Restaurant WITH PAGINATION = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems?page=1
3. Create new Restaurant Record = curl -H "Authorization: Token token=testtoken" -X POST -d "name=testRM1&description=testDes1&category=side&tags=testtag1" http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems
4. Show special Restaurant = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems/1
5. Update Restaurant Record = curl -H "Authorization: Token token=testtoken" -X PUT -d "name=testRM2&description=testDes2&category=side&tags=testtag2" http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems/2
6. Destroy Restaurant Record = curl -H "Authorization: Token token=testtoken" -X DELETE http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems/2


