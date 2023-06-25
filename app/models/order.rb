class Order < ApplicationRecord
  before_validation :set_default_status, :calculate_total, on: :create
  after_update :schedule_order_completion_email, if: :status_completed?
  after_update :schedule_order_completion, if: :status_processing?

  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  accepts_nested_attributes_for :order_items

  enum status: {
    pending: 0,
    processing: 1,
    completed: 2
  }

  private

  def calculate_total
    total = 0
    order_items.each do |order_item|
      total += order_item.item.discounted_price * order_item.quantity * order_item.item.tax_rate
    end

    self.order_total = total
  end

  def set_default_status
    self.status ||= 'pending'
  end

  def status_completed?
    saved_change_to_attribute?('status') && completed?
  end

  def status_processing?
    saved_change_to_attribute?('status') && processing?
  end

  def schedule_order_completion_email
    SendCompletionEmailForOrderJob.perform_later(self)
  end

  def schedule_order_completion
    CompleteOrderJob.set(wait: 5.seconds).perform_later(self)
  end
end
