class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find(params[:id])
  end

  def find
    render json: Merchant.search(search_params)
  end

  def find_all
    render json: Merchant.search_all(search_params)
  end

  def random
    render json: Merchant.find_random
  end

  def most_items
    render json: Merchant.items(params)
  end

  def merchant_invoices
    render json: Merchant.invoices(params)
  end

  private

  def search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
