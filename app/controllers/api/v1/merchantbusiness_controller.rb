class Api::V1::MerchantBusinessController < ApplicationController
  def merchant_items
    render json: Merchant.most_items(params[:quantity])
  end
end
