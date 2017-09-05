# Snappea

Steps to install and run the project

prerequisite:
  1. Ruby 2.3
  2. Rails 4.2

1. Extract the project (Snappea.zip) 
2. Change directory to project directory
3. run $ Rake db:create
4. run $ budle install
5. run $ rails s

Rails server will start successfully.


Rspec Test cases :-

1. Change directory to project directory
2. run $ rspec spec/requests/api/apirequests_spec.rb


Rest Api Calls :-

* Try some Curl Calls as follows

User :- 

List All Users = curl http://localhost:3000/users
Create new User Record = curl -X POST -d "name=test1&email=test1@testmail.com&password=12345678" http://localhost:3000/users
Show special User with userId = curl http://localhost:3000/users/1
Authenticate User using username and password = curl -X POST -d "email=test1@testmail.com&password=12345678" http://localhost:3000/users/login
(This above Authentication call will return token, use it in Restaurant and Restaurantmenuitem rest api calls)
Update User Record = curl -X PUT -d "name=testuser2&email=testuser2@testmail.com&password=12345678" http://localhost:3000/users/1
Destroy Restaurant Record = curl -X DELETE http://localhost:3000/users/1


Restaurants :- 

You can find token user autentication call. Replace 'testtoken' with the token value in below requests. 

List All Restaurant = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants
List All Restaurant WITH PAGINATION = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants?page=1
Create new Restaurant Record = curl -H "Authorization: Token token=testtoken" -X POST -d "name=testR1&description=testD1&rating=0.4&address=testA1" http://localhost:3000/api/v1/restaurants
Create new Restaurant Record for use in restaurantmenuitems api calls = curl -H "Authorization: Token token=testtoken" -X POST -d "name=testR3&description=testD3&rating=0.4&address=testA3" http://localhost:3000/api/v1/restaurants
Show Restaurant with RestaurentId = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants/1
Update Restaurant Record = curl -H "Authorization: Token token=testtoken" -X PUT -d "name=testR2&description=testD2&rating=0.4&address=testA2" http://localhost:3000/api/v1/restaurants/1
Destroy Restaurant Record = curl -H "Authorization: Token token=testtoken" -X DELETE http://localhost:3000/api/v1/restaurants/1


Restaurant menu items :- 

You can find token user autentication call. Replace 'testtoken' with the token value in below requests. 

List All Restaurantmenuitems = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems
List All Restaurant WITH PAGINATION = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems?page=1
Create new Restaurant Record = curl -H "Authorization: Token token=testtoken" -X POST -d "name=testRM1&description=testDes1&category=side&tags=testtag1" http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems
Show special Restaurant = curl -H "Authorization: Token token=testtoken" http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems/1
Update Restaurant Record = curl -H "Authorization: Token token=testtoken" -X PUT -d "name=testRM2&description=testDes2&category=side&tags=testtag2" http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems/2
Destroy Restaurant Record = curl -H "Authorization: Token token=testtoken" -X DELETE http://localhost:3000/api/v1/restaurants/2/restaurantmenuitems/2


