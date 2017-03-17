class Api::V1::TransactionsRelationshipController < ApplicationController
  def invoice
    render json: Transaction.invoice(params)
  end

  private

  def params

  end
end
