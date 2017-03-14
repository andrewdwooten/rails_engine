class Api::V1::InvoicesController < ApplicationController

  def index
    render json: Invoice.all
  end

  def show
    render json: Invoice.find(params[:id])
  end

  def find
    render json: Invoice.search(search_params)
  end

  def random
    render json: Invoice.random
  end

private
  def search_params
    params.permit(:id,
                 :customer_id,
                 :merchant_id,
                 :status,
                 :created_at,
                 :updated_at)
  end

end
