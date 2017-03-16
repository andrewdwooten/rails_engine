class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.items(params)
    find(params[:id]).items
  end

  def self.invoices(params)
    find(params[:id]).invoices
  end

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
end
