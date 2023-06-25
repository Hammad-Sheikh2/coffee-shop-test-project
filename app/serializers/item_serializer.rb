class ItemSerializer
  include JSONAPI::Serializer

  attributes :name, :price, :discounted_price, :free?, :tax_rate

  has_many :deal_items, serializer: 'Item'
end
