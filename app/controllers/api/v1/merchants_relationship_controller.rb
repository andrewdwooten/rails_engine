class Api::V1::MerchantsRelationshipController < ApplicationController
  def merchant_items
    render json: Merchant.items(params)
  end

  def merchant_invoices
    render json: Merchant.invoices(params)
  end

end
