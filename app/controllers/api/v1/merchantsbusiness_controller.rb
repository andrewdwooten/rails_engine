class Api::V1::MerchantsbusinessController < ApplicationController

  def revenue_on_date
    render json: {"total_revenue": Merchant.revenue_on_date(params[:date]).to_s}
  end

  def ranked_by_revenue
    render json: Merchant.ranked_by_revenue(params[:quantity])
  end

  def favorite_customer
    render json: Merchant.favorite_customer(params[:id])[0]
  end
end