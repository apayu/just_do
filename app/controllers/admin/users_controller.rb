class Admin::UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]
  before_action :check_admin

  def index
    @users = User.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)

    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(params_user)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private
  def params_user
    params.require(:user).permit(:user_name, :email, :password)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def check_admin
    if logged_in?
      unless current_user.has_role? :admin
        redirect_to tasks_path, notice: I18n.t("not_admin")
      end
    end
  end
end

