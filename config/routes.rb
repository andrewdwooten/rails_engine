Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      #merchants
      get "/merchants/find" => "merchants#find"
      get "/merchants/find_all" => "merchants#find_all"
      get "/merchants/random" => "merchants#random"
      get "/merchants/revenue" => "merchantsbusiness#revenue_on_date"
      resources :merchants, only: [:index, :show]
      get "/merchants/:id/items(.:format)" => "merchants#merchant_items"
      get "/merchants/:id/invoices(.:format)" => "merchants#merchant_invoices"

      #invoices
      get "/invoices/find" => "invoices#find"
      get "/invoices/random" => "invoices#random"
      get "/invoices/find_all" => "invoices#find_all"
      resources :invoices, only: [:index, :show]
      get "/invoices/:id/transactions" => "invoices#invoice_transactions"
      get "/invoices/:id/invoice_items" => "invoices#find_invoice_items"
      get "/invoices/:id/items" => "invoices#find_items" #here
      get "/invoices/:id/customer" => "invoices#find_customers"
      get "/invoices/:id/merchant" => "invoices#find_merchants"

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
      get "/items/random" => "items#random"
      get "/items/most_revenue" => "itembusiness#most_revenue"
      resources :items, only: [:index, :show]
      get "/items/:id/invoice_items" => "items#find_invoice_items"
      get "/items/:id/merchant" => "items#find_merchant"

      #transactions
      get "/transactions/find" => "transactions#find"
      get "/transactions/find_all" => "transactions#find_all"
      get "/transactions/random" => "transactions#random"
      resources :transactions, only: [:index, :show]
      get "/transactions/:id/invoice" => "transactions#invoice"

      #invoice_items
      get "/invoice_items/find" => "invoice_items#find"
      get "/invoice_items/find_all" => "invoice_items#find_all"
      get "/invoice_items/random" => "invoice_items#random"
      resources :invoice_items, only: [:index, :show]
      get "/invoice_items/:id/invoice" => "invoice_items#find_invoice"
      get "/invoice_items/:id/item" => "invoice_items#find_item"
    end
  end
end
