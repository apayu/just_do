class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(user_name: params[:user_name])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to tasks_path
  end
end
