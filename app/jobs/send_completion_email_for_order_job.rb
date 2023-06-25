class SendCompletionEmailForOrderJob < ApplicationJob
  queue_as :default

  def perform(order)
    OrderMailer.order_completed_email(order).deliver_now
  end
end
