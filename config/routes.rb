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
      get '/api/v1/invoices/:id/transactions' => "invoices#transactions"
      resources :invoices, only: [:index, :show]

      #customers
      get "/customers/find" => "customers#find"
      get "/customers/find_all" => "customers#find_all"
      get "/customers/random" => "customers#random"
      resources :customers, only: [:index, :show]

      #items
      get "/items/find" => "items#find"
      get "/items/find_all" => "items#find_all"
      get "items/random" => "items#random"
      resources :items, only: [:index, :show]

      #transactions
      get "/transactions/find" => "transactions#find"
      get "/transactions/find_all" => "transactions#find_all"
      get "/transactions/random" => "transactions#random"
      resources :transactions, only: [:index, :show]

      #invoice_items
      get "/invoice_items/find" => "invoice_items#find"
      get "/invoice_items/find_all" => "invoice_items#find_all"
      get "invoice_items/random" => "invoice_items#random"
      resources :invoice_items, only: [:index, :show]
    end
  end
end
