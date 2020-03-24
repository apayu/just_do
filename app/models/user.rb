class User < ApplicationRecord
  rolify
  has_secure_password
  has_many :tasks, dependent: :destroy
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:general) if self.roles.blank?
  end
end
