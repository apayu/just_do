class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy]

  def index
    if params["order_by"].nil? & params["order_time"].nil?
      @tasks = Task.order("created_at DESC")
    else
      if params["order_by"] == "created_at"
        if params["order_time"] == "desc"
          @tasks = Task.order("created_at DESC")
          @order_by = "created_at"
          @order_time = "desc"
        else
          @tasks = Task.order("created_at ASC")
          @order_by = "created_at"
          @order_time = "asc"
        end
      else
        if params["order_time"] == "desc"
          @tasks = Task.order("finish_time DESC")
          @order_by = "finish_time"
          @order_time = "desc"
        else
          @tasks = Task.order("finish_time ASC")
          @order_by = "finish_time"
          @order_time = "asc"
        end
      end
    end
  end

  def oerder
    if params["order"] == "desc"
      @tasks = Task.order("created_at desc")
    else
      @tasks = Task.order("created_at asc")
    end

    render "index"
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
    params.require(:task).permit(:name, :content, :finish_time)
  end
end

