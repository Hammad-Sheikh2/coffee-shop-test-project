class OrderSerializer
  include JSONAPI::Serializer

  attributes :order_total, :status

  belongs_to :user
  has_many :items
end
