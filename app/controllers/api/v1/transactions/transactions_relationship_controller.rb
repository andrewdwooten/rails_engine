class Api::V1::Transactions::TransactionsRelationshipController < ApplicationController
  def invoice

    render json: Transaction.invoice(params)
  end

  # private
  #
  # def params
  #
  # end
end
