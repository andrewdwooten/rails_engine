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
      get '/invoices/random' => "invoices#random"
      get '/invoices/find_all' => "invoices#find_all"
      resources :invoices, only: [:index, :show]


      #customers
      get "/customers/find" => "customers#find"
      get "/customers/find_all" => "customers#find_all"
      get "/customers/random" => "customers#random"
      resources :customers, only: [:index, :show]
    end
  end
end
