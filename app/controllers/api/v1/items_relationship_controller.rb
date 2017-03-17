class Api::V1::ItemsRelationshipController < ApplicationController
  def find_invoice_items
    render json: Item.find(params[:id]).invoice_items
  end

  def find_merchant
    render json: Item.find(params[:id]).merchant
  end

  private 

  def params

  end
end
