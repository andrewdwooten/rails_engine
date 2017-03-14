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

  def find_all
    
    render json: Customer.search_all(search_params)
  end

  def random
    render json: Customer.find_random
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
