class Api::V1::CustomersController < ApplicationController

  def index
    render json: Customer.all
  end

  def show
    render json: Customer.find(params[:id])
  end

  def find
    render json: Customer.search(search_params)
  end

  private

  def search_params
    params.permit( :id,
                   :first_name,
                   :last_name,
                   :created_at,
                   :updated_at)
  end
end
