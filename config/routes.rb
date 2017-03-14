Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/invoices/find' => "invoices#find"
      get '/invoices/random' => "invoices#random"
      get '/invoices/find_all' => "invoices#find_all"
      resources :invoices, only: [:index, :show]
      resources :merchants, only: [:index, :show] do

      end
    end
  end
end
