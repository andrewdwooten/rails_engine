Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      get "/merchants/find" => "merchants#find"
      get "/merchants/find_all" => "merchants#find_all"
      get "/merchants/random" => "merchants#random"
      resources :merchants, only: [:index, :show]

      get '/invoices/find' => "invoices#find"
      resources :invoices, only: [:index, :show]

    end
  end
end
