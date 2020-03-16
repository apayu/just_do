class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy]

  def index
    @order_by = params["order_by"] || :created_at
    @order_time = params["order_time"] || :created_at

    unless params["q"].nil?
      @tasks = Task.order_task(@order_by, @order_time).ransack(name_cont: params[:q], content_cont: params[:q], m: "or").result
    else
      @tasks = Task.order_task(@order_by, @order_time)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

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
    params.require(:task).permit(:name, :content, :finish_time, :state)
  end
end

