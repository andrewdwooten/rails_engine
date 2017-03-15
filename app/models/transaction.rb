class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.invoice(params)
    find(params[:id]).invoice
  end
end
