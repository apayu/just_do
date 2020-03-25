class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)

    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render :new
    end
  end

  private
  def params_user
    params.require(:user).permit(:user_name, :email, :password, :avatar)
  end
end
