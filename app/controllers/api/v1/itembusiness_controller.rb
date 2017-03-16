class Api::V1::ItembusinessController < ApplicationController

  def most_revenue
    render json: Item.most_revenue(params[:quantity])
  end
end
