class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find(params[:id])
  end

  def find
    render json: Merchant.find_by(query_params)
  end

  private

  def query_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
