class Api::V1::InvoicesRelationshipController < ApplicationController
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

end
