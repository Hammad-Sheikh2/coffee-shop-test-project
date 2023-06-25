ActiveRecord::Base.transaction do
  user1 = User.create(email: 'johndoe@example.com', password: 'password123')
  user2 = User.create(email: 'janesmith@example.com', password: 'password456')
  User.create(email: 'bobjohnson@example.com', password: 'password789')

  item1 = Item.create(name: 'Coffee', price: 2.5, tax_rate: 0.10,
                      discount_type: Constants::DISCOUNT_TYPES[:none], discount_amount: 0)
  item2 = Item.create(name: 'Sandwich', price: 5.0, tax_rate: 0.15,
                      discount_type: Constants::DISCOUNT_TYPES[:fixed_amount], discount_amount: 1.0)
  item3 = Item.create(name: 'Muffin', price: 2.0, tax_rate: 0.10,
                      discount_type: Constants::DISCOUNT_TYPES[:percentage], discount_amount: 30)
  item4 = Item.create(name: 'Deal 1', tax_rate: 0.15,
                      discount_type: Constants::DISCOUNT_TYPES[:fixed_amount], discount_amount: 2.5,
                      deal_items: [item1, item2])
  item5 = Item.create(name: 'Deal 2', tax_rate: 0.40,
                      discount_type: Constants::DISCOUNT_TYPES[:percentage], discount_amount: 40,
                      deal_items: [item2, item3])
  Item.create(name: 'Juice', price: 3.0, tax_rate: 0.10, discount_type: Constants::DISCOUNT_TYPES[:percentage],
              discount_amount: 100)

  Order.create(user: user1, status: 'completed', order_items: [OrderItem.new(item: item1, quantity: 2),
                                                               OrderItem.new(item: item2, quantity: 1)])
  Order.create(user: user2, order_items: [OrderItem.new(item: item2, quantity: 3),
                                          OrderItem.new(item: item3, quantity: 2)])
  Order.create(user: user1, order_items: [OrderItem.new(item: item4, quantity: 2)])
  Order.create(user: user2, order_items: [OrderItem.new(item: item5, quantity: 3)])
end
