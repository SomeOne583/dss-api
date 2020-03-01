Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      get '', to: 'maze#index'
      get 'maze', to: 'maze#index'
      get 'maze/:size', to: 'maze#index'
    end
  end
end
