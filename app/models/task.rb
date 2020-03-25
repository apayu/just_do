class Task < ApplicationRecord
  include AASM
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many_attached :document
  validates :name, presence: true

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |item|
      Tag.where(name: item.strip).first_or_create!
    end
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).tasks
  end

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
