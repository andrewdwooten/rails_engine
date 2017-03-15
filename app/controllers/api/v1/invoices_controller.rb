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

  def find_all
    render json: Invoice.search_all(search_params)
  end

  def random
    render json: Invoice.find_random
  end

  def invoice_transactions
    render json: Invoice.find(params[:id]).transactions
  end

  def find_invoice_items
    render json: Invoice.find(params[:id]).invoice_items
  end

  def find_items
    render json: Invoice.find(params[:id]).items
  end

  def find_customers
    render json: Invoice.find(params[:id]).customer
  end

  def find_merchants
    render json: Invoice.find(params[:id]).merchant
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
