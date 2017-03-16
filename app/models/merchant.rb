class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.items(params)
    find(params[:id]).items
  end

  def self.invoices(params)
    find(params[:id]).invoices
  end

  def most_items(amount)
    joins(items: [:invoices, :invoice_items])
    .group(:id)
    .order("sum(quantity) DESC")
    .limit(amount)
  end
end
