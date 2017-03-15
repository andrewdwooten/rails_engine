class ItemSerializer < ActiveModel::Serializer
  attributes :id, :description, :name, :merchant_id, :unit_price
end
