require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "GET index" do
    it "assigns @tasks" do
      task1 = Task.create(name: "123", content: "456")
      task2 = Task.create(name: "789", content: "888")

      get :index

      expect(assigns[:tasks]).to eq([task1, task2])
    end

    # it "render page index" do
    #
    #   get :index
    #
    #   expect(response).to render_template("index")
    # end
  end

  describe "GET new" do
    it "assigns new @task" do
      task = Task.new

      get :new

      expect(assigns[:task]).to be_a_new(Task)
    end

    # it "render page new" do
    #   get :new
    #
    #   expect(response).to render_template("new")
    # end
  end

  describe "Post create" do
    it "create new task" do

      expect do
        post :create, params: { :task => {name: "sss", content: "678" }}
      end.to change{ Task.count }.by(1)
    end

    # it "if success redirect to tasks_path" do
    #   post :create, params: { :task => {name: "sss", content: "678" }}
    #   expect(response).to redirect_to tasks_path
    # end

    it "if fail render new" do
    end
  end

  describe "GET edit" do
    it "find and assigns @task" do
      task = Task.create(name: "ggg", content: "sss")

      get :edit, params: { :id => task.id }

      expect(assigns[:task]).to eq(task)
    end

    # it "render page edit" do
    #   task = Task.create(name: "ggg", content: "sss")
    #   get :edit, params: { :id => task.id }
    #
    #   expect(response).to render_template("edit")
    # end
  end

  describe "Put create" do
    it "update task" do
      task = Task.create(name: "123", content: "456")
      put :update, params: { id: task.id, task: { name: "321", content: "789"}}
      expect(assigns[:task].name).to eq("321")
      expect(assigns[:task].content).to eq("789")
    end

    # it "redirect to index" do
    #   task = Task.create(name: "123", content: "456")
    #   put :update, params: { id: task.id, task: { name: "321", content: "789"}}
    #   expect(response).to redirect_to tasks_path
    # end
  end

  describe "Delete destory" do
    it "delete a record" do
      task = Task.create(name: "8787", content: "9999")
      expect { delete :destroy, params: { id: task.id }}.to change { Task.count }.by(-1)
    end

    # it "redirect to index" do
    #   task = Task.create(name: "8787", content: "9999")
    #   delete :destroy, params: { id: task.id }
    #   expect(response).to redirect_to tasks_path
    # end
  end
end
