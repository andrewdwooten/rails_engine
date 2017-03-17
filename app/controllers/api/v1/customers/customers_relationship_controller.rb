class Api::V1::Customers::CustomersRelationshipController < ApplicationController
  def invoices
    render json: Customer.invoices(params)
  end

  def transactions
    render json: Customer.transactions(params)
  end

  # private
  #
  # def params
  #
  # end
end
