class Admin::TasksController < ApplicationController
  before_action :check_admin
  def index
    @user = User.find_by(id: params[:user_id])
  end

  private
  def check_admin
    if logged_in?
      unless current_user.has_role? :admin
        redirect_to tasks_path
      end
    end
  end
end

