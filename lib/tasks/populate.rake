require 'csv'
require './app/models/application_record.rb'
require './app/models/customer.rb'
require './app/models/invoice_item.rb'
require './app/models/invoice.rb'
require './app/models/item.rb'
require './app/models/merchant.rb'
require './app/models/transaction.rb'
require 'rake'


task :populate => :environment do
  customer_file = './db/csv/customers.csv'
  customers = File.read(customer_file)
  customer_cells = CSV.parse(customers, headers: true)
  customer_cells.each do |row|
    Customer.create!(
      id: row[0],
      first_name: row[1],
      last_name: row[2],
      created_at: row[3],
      updated_at: row[4]
    )
  end

 puts "Populated #{Customer.count} customers to database"
  merchant_file = './db/csv/merchants.csv'
  merchants = File.read(merchant_file)
  merchant_cells = CSV.parse(merchants, headers: true)
  merchant_cells.each do |row|
    Merchant.create!(
      id: row[0],
      name: row[1],
      created_at: row[2],
      updated_at: row[3]
    )

  end

  puts "Populated #{Merchant.count} merchants to database"
  item_file = './db/csv/items.csv'
  items = File.read(item_file)
  item_cells = CSV.parse(items, headers: true)
  item_cells.each do |row|
    Item.create!(
      id: row[0],
      name: row[1],
      description: row[2],
      unit_price: (row[3].to_i / 100),
      merchant_id: row[4],
      created_at: row[5],
      updated_at: row[6]
    )

  end

  puts "Populated #{Item.count} items to database"
  invoice_file = './db/csv/invoices.csv'
  invoices = File.read(invoice_file)
  invoice_cell = CSV.parse(invoices, headers: true)
  invoice_cell.each do |row|
    Invoice.create!(
      id: row[0],
      customer_id: row[1],
      merchant_id: row[2],
      status: row[3],
      created_at: row[4],
      updated_at: row[5]
    )
  end

  puts "Populated #{Invoice.count} invoices to database"
  invoice_items_file = './db/csv/invoice_items.csv'
  invoice_items = File.read(invoice_items_file)
  invoice_items_cells = CSV.parse(invoice_items, headers: true)
  invoice_items_cells.each do |row|
    InvoiceItem.create!(
      id: row[0],
      item_id: row[1],
      invoice_id: row[2],
      quantity: row[3],
      unit_price: (row[4].to_i / 100 ),
      created_at: row[5],
      updated_at: row[6]
    )
  end

  puts "Populated #{InvoiceItem.count} InvoiceItems to database"
  transaction_file = './db/csv/invoices.csv'
  transactions = File.read(transaction_file)
  transactions_cell = CSV.parse(transactions, headers: true)
  transactions_cell.each do |row|
    Transaction.create!(
      id: row[0],
      invoice_id: row[1],
      credit_card_number: row[2],
      credit_card_expiration_date: row[3],
      result: row[4],
      created_at: row[5],
      updated_at: row[6]
    )
  end

  puts "Populated #{Transaction.count} transactions to database"

end
