class Api::V1::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItem.all
  end

  def show
    render json: InvoiceItem.find(params[:id])
  end

  def find
    render json: InvoiceItem.search(search_params)
  end

  def find_all
    render json: InvoiceItem.search_all(search_params)
  end

  def random
    render json: InvoiceItem.find_random
  end

  def find_invoice
    render json: InvoiceItem.find(params[:id]).invoice
  end

  def find_item
    render json: InvoiceItem.find(params[:id]).item
  end

private
  def search_params
    params.permit(:id,
                 :item_id,
                 :invoice_id,
                 :quantity,
                 :unit_price,
                 :created_at,
                 :updated_at)
  end

end
