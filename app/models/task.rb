class Task < ApplicationRecord
  include AASM
  validates :name, presence: true

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
