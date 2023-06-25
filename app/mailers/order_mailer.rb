class OrderMailer < ApplicationMailer
  def order_completed_email(order)
    @order = order
    mail(to: order.user.email, subject: 'Your Order Details')
  end
end
