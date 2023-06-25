class CompleteOrderJob < ApplicationJob
  queue_as :default

  def perform(order)
    ActiveRecord::Base.transaction do
      order.update(status: 'completed')
    end
  end
end
