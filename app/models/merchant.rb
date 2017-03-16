class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.items(params)
    find(params[:id]).items
  end

  def self.invoices(params)
    find(params[:id]).invoices
  end

  def self.most_items(amount)
    joins(invoices: [:invoice_items, :items])
    .group(:id)
    .order("sum(invoice_items.quantity) DESC")
    .limit(amount)
  end

  def self.revenue_on_date(date)
    joins.
  end
end
