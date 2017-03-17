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
end
