class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

    def self.search(params)
      find_by(filter(params))
    end

    def self.search_all(params)
      where(filter(params))
    end

    def self.find_random
      order("Random()").limit(1)
    end

    def self.filter(params)
      case
        when params[:status]
          params[:status] = params[:status].downcase.capitalize
        when params[:created_at]
          params[:created_at] = params[:created_at].to_time.in_time_zone
        when params[:updated_at]
          params[:updated_at] = params[:updated_at].to_time.in_time_zone
      end
      params
    end
end
