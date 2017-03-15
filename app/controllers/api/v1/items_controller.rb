class Api::V1::ItemsController < ApplicationController

  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

  def find
    render json: Item.search(search_params)
  end

  def random
    render json: Item.find_random
  end

  def find_all
    render json: Item.search_all(search_params)
  end

  def find_invoice_items
    render json: Item.find(params[:id]).invoice_items
  end

  def find_merchant
    render json: Item.find(params[:id]).merchant
  end

private
  def search_params
    params.permit(:id,
                  :name,
                  :description,
                  :unit_price,
                  :merchant_id,
                  :created_at,
                  :updated_at)
  end
end
