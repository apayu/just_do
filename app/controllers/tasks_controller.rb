class TasksController < ApplicationController
  before_action :authorized, except:[:index]
  before_action :find_task, only: [:edit, :update, :destroy]

  def index
    @order_by = params["order_by"] || :created_at
    @order_time = params["order_time"] || :created_at
    @state = params["state"] || "pending"
    @priority = params["priority"] || 0
    @q = params["q"] || ""

    user_id = logged_in? ? current_user.id : nil

    @tasks = Task.where(user_id: user_id).order_task(@order_by, @order_time).ransack(name_or_tags_name_cont: @q, state_eq: @state).result.group(:id).page params[:page]
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: I18n.t("create_success")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path,notice: I18n.t("edit_success")
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: I18n.t("delete_success")
  end

  private

  def find_task
    @task = Task.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content, :finish_time, :state, :priority, :tag_list, document: [])
  end
end

