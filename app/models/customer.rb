class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  accepts_nested_attributes_for :transactions
  
  def self.invoices(params)
    find(params[:id]).invoices
  end

  def self.transactions(params)
    find(params[:id]).transactions
  end
end
