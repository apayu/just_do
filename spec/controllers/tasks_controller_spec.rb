require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "GET index" do
    context "search" do
      context "by name" do
        it "assigns @tasks" do
          task1 = create(:task)
          task2 = create(:task)

          get :index, params: { q: task2.name }

          expect(assigns[:tasks].first.name).to eq(task2.name)
        end
      end

      context "by state" do
        it "assigns @tasks" do
          task1 = create(:task)
          task2 = create(:task)

          task2.update(state: "finish")

          get :index, params: { state: "finish" }

          expect(assigns[:tasks].first.name).to eq(task2.name)
        end
      end
    end

    context "order by priority" do
      context "order by desc" do
        it "assigns @tasks" do
          task1 = create(:task)
          task2 = create(:task)
          task2.update(priority: 2)

          get :index, params: { order_by: "priority", order_time: "desc" }

          expect(assigns[:tasks]).to eq([task2, task1])
        end
      end
      context "order by asc" do
        it "assigns @tasks" do
          task1 = create(:task)
          task2 = create(:task)
          task2.update(priority: 2)

          get :index, params: { order_by: "priority", order_time: "asc" }

          expect(assigns[:tasks]).to eq([task1, task2])
        end
      end
    end

    context "order by created_at" do
      context "order by desc" do
        it "assigns @tasks" do
          task1 = create(:task)
          task2 = create(:task)

          get :index, params: { order_by: "created_at", order_time: "desc" }

          expect(assigns[:tasks]).to eq([task2, task1])
        end
      end
      context "order by asc" do
        it "assigns @tasks" do
          task1 = create(:task)
          task2 = create(:task)

          get :index, params: { order_by: "created_at", order_time: "asc" }

          expect(assigns[:tasks]).to eq([task1, task2])
        end
      end
    end

    context "order by finish_time" do
      context "order by desc" do
        it "assigns @tasks" do
          task1 = create(:task)
          task2 = create(:task)
          task2.update(finish_time: DateTime.now)

          get :index, params: { order_by: "finish_time", order_time: "desc" }

          expect(assigns[:tasks]).to eq([task2, task1])
        end
      end
      context "order by asc" do
        it "assigns @tasks" do
          task1 = create(:task)
          task2 = create(:task)
          task2.update(finish_time: DateTime.now)

          get :index, params: { order_by: "finish_time", order_time: "asc" }

          expect(assigns[:tasks]).to eq([task1, task2])
        end
      end
    end

    it "render page index" do
      get :index

      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "assigns new @task" do
      task = build(:task)

      get :new

      expect(assigns[:task]).to be_a_new(Task)
    end

    it "render page new" do
      get :new

      expect(response).to render_template("new")
    end
  end

  describe "Post create" do
    it "create new task" do
      task = create(:task)

      expect do
        post :create, params: { :task => attributes_for(:task)}
      end.to change{ Task.count }.by(1)
    end

    it "if success redirect to tasks_path" do
      task = create(:task)
      post :create, params: { :task => attributes_for(:task)}
      expect(response).to redirect_to tasks_path
    end

    it "if fail render new" do
    end
  end

  describe "GET edit" do
    it "find and assigns @task" do
      task = create(:task)
      get :edit, params: { :id => task.id }
      expect(assigns[:task]).to eq(task)
    end

    it "render page edit" do
      task = create(:task)
      get :edit, params: { :id => task.id }
      expect(response).to render_template("edit")
    end
  end

  describe "Put update" do
    it "update task" do
      task = create(:task)
      put :update, params: { id: task.id, task: { name: "321", content: "789"}}
      expect(assigns[:task].name).to eq("321")
      expect(assigns[:task].content).to eq("789")
    end

    it "redirect to index" do
      task = create(:task)
      put :update, params: { id: task.id, task: { name: "321", content: "789"}}
      expect(response).to redirect_to tasks_path
    end
  end

  describe "Delete destory" do
    it "delete a record" do
      task = create(:task)
      expect { delete :destroy, params: { id: task.id }}.to change { Task.count }.by(-1)
    end

    it "redirect to index" do
      task = create(:task)
      delete :destroy, params: { id: task.id }
      expect(response).to redirect_to tasks_path
    end
  end
end
