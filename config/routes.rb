Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # Merchants
      #----------#
        # Business Intelligence
          get "/merchants/most_items" => "merchants_business#most_items"
          get "/merchants/revenue" => "merchants_business#revenue_on_date"
          get "/merchants/most_revenue" => "merchants_business#ranked_by_revenue"
          get "/merchants/:id/favorite_customer" => "merchants_business#favorite_customer"
          
        # Records
          get "/merchants/find" => "merchants#find"
          get "/merchants/find_all" => "merchants#find_all"
          get "/merchants/random" => "merchants#random"
          resources :merchants, only: [:index, :show]

        # Relationships
          get "/merchants/:id/items" => "merchants_relationship#merchant_items"  #
          get "/merchants/:id/invoices" => "merchants_relationship#merchant_invoices"


      # Invoices
      #----------#
        # Business Intelligence


        # Records
          get "/invoices/find" => "invoices#find"
          get "/invoices/find_all" => "invoices#find_all"
          get "/invoices/random" => "invoices#random"
          resources :invoices, only: [:index, :show]

        # Relationships
          get "/invoices/:id/transactions" => "invoices_relationship#invoice_transactions"
          get "/invoices/:id/invoice_items" => "invoices_relationship#find_invoice_items"
          get "/invoices/:id/items" => "invoices_relationship#find_items"
          get "/invoices/:id/customer" => "invoices_relationship#find_customers"
          get "/invoices/:id/merchant" => "invoices_relationship#find_merchants"



      # Customers
      #----------#
        # Business Intelligence


        # Records
          get "/customers/find" => "customers#find"
          get "/customers/find_all" => "customers#find_all"
          get "/customers/random" => "customers#random"
          resources :customers, only: [:index, :show]

        # Relationships
          get "/customers/:id/invoices(.:format)" => "customers_relationship#invoices"
          get "/customers/:id/transactions" => "customers_relationship#transactions"


      # Items
      #-------#
        # Business Intelligence
          get "/items/most_revenue" => "items_business#most_revenue"

        # Records
          get "/items/find" => "items#find"
          get "/items/find_all" => "items#find_all"
          get "/items/random" => "items#random"
          resources :items, only: [:index, :show]

        # Relationships
          get "/items/:id/invoice_items" => "items_relationship#find_invoice_items"
          get "/items/:id/merchant" => "items_relationship#find_merchant"


      # Transactions
      #--------------#
        # Business Intelligence

        # Records
          get "/transactions/find" => "transactions#find"
          get "/transactions/find_all" => "transactions#find_all"
          get "/transactions/random" => "transactions#random"
          resources :transactions, only: [:index, :show]

        # Relationships
          get "/transactions/:id/invoice" => "transactions_relationship#invoice"


      # Invoice_Items
      #----------------#
        # Business Intelligence

        # Records
          get "/invoice_items/find" => "invoice_items#find"
          get "/invoice_items/find_all" => "invoice_items#find_all"
          get "/invoice_items/random" => "invoice_items#random"
          resources :invoice_items, only: [:index, :show]

        # Relationships
          get "/invoice_items/:id/invoice" => "invoice_items_relationship#find_invoice"
          get "/invoice_items/:id/item" => "invoice_items_relationship#find_item"
    end
  end
end
