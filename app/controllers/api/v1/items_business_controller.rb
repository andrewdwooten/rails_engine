class Api::V1::ItemsBusinessController < ApplicationController
  def most_revenue
    render json: Item.most_revenue(params[:quantity])
  end

end
