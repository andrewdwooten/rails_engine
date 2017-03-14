class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.search(params)
    Merchant.find_by(Merchant.filter(params))
  end

  def self.filter(params)
    case
      when params[:name]
        params[:name] = params[:name].downcase.capitalize
      when params[:created_at]
        params[:created_at] = params[:created_at].to_time.in_time_zone
      when params[:updated_at]
        params[:updated_at] = params[:updated_at].to_time.in_time_zone
    end
    params
  end
end
