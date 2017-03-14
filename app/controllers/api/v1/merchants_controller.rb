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

  # def find_all
  #   render json: Merchant.where(search_params)
  # end

  private

  def search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
