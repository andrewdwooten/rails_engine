Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        # Business Intelligence
          get "/most_items" => "merchants_business#most_items"
          get "/revenue" => "merchants_business#revenue_on_date"
          get "/:id/revenue" => "merchants_business#revenue"
        # Records
          get "/find" => "merchants#find"
          get "/find_all" => "merchants#find_all"
          get "/random" => "merchants#random"
          get "/:id" => "merchants#show"
          get "/" => "merchants#index"
        # Relationships
          get "/:id/items" => "merchants_relationship#merchant_items"  #
          get "/:id/invoices" => "merchants_relationship#merchant_invoices"
      end

      namespace :invoices do
        # Business Intelligence
        # Records
          get "/find" => "invoices#find"
          get "/find_all" => "invoices#find_all"
          get "/random" => "invoices#random"
          get "/:id" => "invoices#show"
          get "/" => "invoices#index"
        # Relationships
          get "/:id/transactions" => "invoices_relationship#invoice_transactions"
          get "/:id/invoice_items" => "invoices_relationship#find_invoice_items"
          get "/:id/items" => "invoices_relationship#find_items"
          get "/:id/customer" => "invoices_relationship#find_customers"
          get "/:id/merchant" => "invoices_relationship#find_merchants"
      end

      namespace :customers do
        # Business Intelligence
        # Records
          get "/find" => "customers#find"
          get "/find_all" => "customers#find_all"
          get "/random" => "customers#random"
          get "/:id" => "customers#show"
          get "/" => "customers#index"
        # Relationships
          get "/:id/invoices" => "customers_relationship#invoices"
          get ":id/transactions" => "customers_relationship#transactions"
      end

      namespace :items do
        # Business Intelligence
          get "/most_revenue" => "items_business#most_revenue"
        # Records
          get "/find" => "items#find"
          get "/find_all" => "items#find_all"
          get "/random" => "items#random"
          get "/:id" => "items#show"
          get "/" => "items#index"
        # Relationships
          get "/:id/invoice_items" => "items_relationship#find_invoice_items"
        get "/:id/merchant" => "items_relationship#find_merchant"
      end

      namespace :transactions do
        # Business Intelligence
        # Records
            get "/find" => "transactions#find"
            get "/find_all" => "transactions#find_all"
            get "/random" => "transactions#random"
            get "/:id" => "transactions#show"
            get "/" => "transactions#index"
        # Relationships
          get "/:id/invoice" => "transactions_relationship#invoice"
      end

      namespace :invoice_items do
        # Business Intelligence
        # Records
          get "/find" => "invoice_items#find"
          get "/find_all" => "invoice_items#find_all"
          get "/random" => "invoice_items#random"
          get "/:id" => "invoice_items#show"
          get "/" => "invoice_items#index"
        # Relationships
          get "/:id/invoice" => "invoice_items_relationship#find_invoice"
          get "/:id/item" => "invoice_items_relationship#find_item"
      end
    end
  end
end
