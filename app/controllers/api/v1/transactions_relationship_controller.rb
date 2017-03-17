class Api::V1::TransactionsRelationshipController < ApplicationController
  def invoice
    render json: Transaction.invoice(params)
  end

end
