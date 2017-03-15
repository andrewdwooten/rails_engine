Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      #merchants
      get "/merchants/find" => "merchants#find"
      get "/merchants/find_all" => "merchants#find_all"
      get "/merchants/random" => "merchants#random"
      resources :merchants, only: [:index, :show]
      get "/merchants/:id/items(.:format)" => "merchants#merchant_items"
      get "/merchants/:id/invoices(.:format)" => "merchants#merchant_invoices"

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
      get "/customers/:id/invoices" => "customers#invoices"
      get "customers/:id/transactions" => "customers#transactions"

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
      get "/transactions/:id/invoice" => "transactions#invoice"

      #invoice_items
      get "/invoice_items/find" => "invoice_items#find"
      get "/invoice_items/find_all" => "invoice_items#find_all"
      get "invoice_items/random" => "invoice_items#random"
      resources :invoice_items, only: [:index, :show]
    end
  end
end
