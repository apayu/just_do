class User < ApplicationRecord
  rolify
  has_secure_password
  has_many :tasks, dependent: :destroy
  after_create :assign_default_role
  before_update :check_last_admin
  before_destroy :destroy_check_last_admin

  private
  def assign_default_role
    self.add_role(:general) if self.roles.blank?
  end

  def check_last_admin
    user_role = User.joins(:roles).where(roles: {name: "admin"})

    if user_role.count == 0
      errors.add(:base, "last_admin")
      throw :abort
    end
  end

  def destroy_check_last_admin
    user_role = User.joins(:roles).where(roles: {name: "admin"})

    if user_role.count == 1 && user_role[0].id == self.id
      errors.add(:base, "last_admin")
      throw :abort
    end
  end
end
