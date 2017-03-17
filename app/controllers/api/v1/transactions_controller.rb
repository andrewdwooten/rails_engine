class Api::V1::TransactionsController < ApplicationController
  def index
    render json: Transaction.all
  end

  def show
    render json: Transaction.find(params[:id])
  end

  def find
    render json: Transaction.search(search_params)
  end

  def find_all
    render json: Transaction.search_all(search_params)
  end

  def random
    render json: Transaction.find_random
  end

  private

  def search_params
    params.permit( :id,
                   :invoice_id,
                   :credit_card_number,
                   :credit_card_expiration_date,
                   :result,
                   :created_at,
                   :updated_at)
  end
end
