class Api::V1::Items::ItemsBusinessController < ApplicationController
  def most_revenue
    render json: Item.most_revenue(params[:quantity])
  end

  # private
  #
  # def params
  #
  # end
end
