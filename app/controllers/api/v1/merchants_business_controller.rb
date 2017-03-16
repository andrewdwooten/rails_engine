class Api::V1::MerchantsBusinessController < ApplicationController

  def most_items
    render json: Merchant.most_items(params[:quantity])
  end

  def revenue_on_date
    render json: Merchant.revenue_on_date(params[:date])
  end

end
