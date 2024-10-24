Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "tokens/create"
    end
  end
  # API definitions
  namespace :api, defaults: {format: :json} do
    # we are going to list our resources here
      namespace :v1 do
        resources :users, only: %i[show create update destroy] 
        resources :tokens, only: %i[create]
        resources :products
        resources :orders, only: %i[index show create]
      end
  end
end
