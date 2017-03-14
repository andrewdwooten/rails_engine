Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      #merchants
      get "/merchants/find" => "merchants#find"
      get "/merchants/find_all" => "merchants#find_all"
      get "/merchants/random" => "merchants#random"
      resources :merchants, only: [:index, :show]

      #invoices
      get '/invoices/find' => "invoices#find"
      resources :invoices, only: [:index, :show]


      #customers
      get "/customers/find" => "customers#find"
      resources :customers, only: [:index, :show]
    end
  end
end
