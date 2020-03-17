class Task < ApplicationRecord
  include AASM
  validates :name, presence: true


  def self.order_task(order_by = :created_at, order_time = :desc)
    sort_hash = {
      created_at: { desc: "created_at desc", asc: "created_at asc" },
      finish_time: { desc: "finish_time desc", asc: "finish_time asc" },
      priority: { desc: "priority desc", asc: "priority asc" }
    }

    order(sort_hash[order_by.to_sym][order_time.to_sym])
  end

  aasm column: :state do
    state :pending, initial: true
    state :pending, :processing, :finish

    event :to_do do
      transitions from: :pending, to: :processing
    end

    event :to_finish do
      transitions from: :processing, to: :finish
    end
  end
end
