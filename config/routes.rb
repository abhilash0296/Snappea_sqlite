Rails.application.routes.draw do
  resources :users  
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :restaurants do
        resources :restaurantmenuitems
      end  
    end
  end
  post "users/login", to: "users#login"
end
