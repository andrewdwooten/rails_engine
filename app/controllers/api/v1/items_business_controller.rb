class Api::V1::ItemsBusinessController < ApplicationController

  def most_revenue
    render json: Item.most_revenue(params[:quantity])
  end

  def best_day
    render json: {"best_day": Item.best_day(params[:id])}
  end

end
