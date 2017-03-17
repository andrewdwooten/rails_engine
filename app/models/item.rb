class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  accepts_nested_attributes_for :transactions

#go into application__record?
  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .group(:id)
    .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
    .limit(quantity)
  end

  def self.best_day(id)
    Invoice.joins(:invoice_items, :transactions)
    .joins(:items)
    .where(transactions: {result: "success"},
           items:        {id: id})
    .group(:id)
    .order("sum(invoice_items.quantity) DESC")
    .pluck(:created_at).first
  end

  def self.most_items(quantity)
    joins(:invoice_items)
    .joins(invoices: :transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .order('count(transactions.*) DESC')
    .limit(quantity)
  end
end
