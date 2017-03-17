class Api::V1::MerchantsRelationshipController < ApplicationRecord
  def merchant_items
    render json: Merchant.items(params)
  end

  def merchant_invoices
    render json: Merchant.invoices(params)
  end

  private

  def merchant_params
    #...
  end
end
