class OrderItemSerializer
  include JSONAPI::Serializer

  attributes :quantity

  belongs_to :item
end
