class Api::V1::InvoiceItems::InvoiceItemsRelationshipController < ApplicationController
  def find_invoice
    render json: InvoiceItem.find(params[:id]).invoice
  end

  def find_item
    render json: InvoiceItem.find(params[:id]).item
  end

  # private
  #
  # def params
  #
  # end
end
