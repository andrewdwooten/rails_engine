class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.items(params)
    find(params[:id]).items
  end

  def self.invoices(params)
    find(params[:id]).invoices
  end

#go into application__record
  def self.most_items(amount)
    joins(invoices: [:invoice_items, :items])
    .group(:id)
    .order("sum(invoice_items.quantity) DESC")
    .limit(amount)
  end

#go into application__record
  def self.revenue_on_date(date)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .where(invoices: {created_at: date})
    .sum('quantity * unit_price')
  end

  def self.ranked_by_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .group(:id)
    .order("sum(quantity * unit_price) DESC")
    .limit(quantity)
  end

  def self.favorite_customer(id)
    Customer.joins(invoices: :transactions)
      .joins("INNER JOIN merchants ON merchants.id = invoices.merchant_id")
      .where(transactions: {result: "success"})
      .where(merchants: {id: id})
      .group(:id)
      .order('count(transactions.*) DESC')
      .limit(1)
  end
end
