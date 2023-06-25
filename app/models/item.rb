class Item < ApplicationRecord
  before_validation :set_deal_price, on: :create, if: :deal?

  validates :name, presence: true
  validates :discount_type, inclusion: { in: Constants::DISCOUNT_TYPES.values }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tax_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :discount_amount, numericality: { greater_than_or_equal_to: 0 }, if: :discounted?

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_and_belongs_to_many :deal_items, class_name: 'Item', dependent: :destroy, join_table: 'deal_items',
                                  foreign_key: 'item_id', association_foreign_key: 'deal_id'
  has_and_belongs_to_many :deals, class_name: 'Item', dependent: :destroy, join_table: 'deal_items',
                                  foreign_key: 'deal_id', association_foreign_key: 'item_id'

  def discount_type
    super || Constants::DISCOUNT_TYPES[:none]
  end

  def discount_amount
    super || 0
  end

  def discounted_price
    case discount_type
    when Constants::DISCOUNT_TYPES[:fixed_amount]
      price - discount_amount
    when Constants::DISCOUNT_TYPES[:percentage]
      price - (price * (discount_amount / 100.0))
    else
      price
    end
  end

  def free?
    discounted_price.zero?
  end

  def discounted?
    discount_type != Constants::DISCOUNT_TYPES[:none]
  end

  def deal?
    !deal_items.empty?
  end

  private

  def set_deal_price
    total = 0
    deal_items.each do |item|
      total += item.price
    end

    self.price = total
  end
end
