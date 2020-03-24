require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "GET index" do
    context "user login" do
      it "get user's task" do
        user = create(:user)
        task = create(:task)
        session[:user_id] = user.id

        get :index

        assigns[:tasks].each do |task|
          expect(task.user.id).to eq(user.id)
        end
      end
    end

    context "search" do
      context "by name" do
        it "assigns @tasks" do
          user = create(:user)
          task1 = create(:task, user: user)
          task2 = create(:task, user: user)
          session[:user_id] = user.id

          get :index, params: { q: task2.name }

          expect(assigns[:tasks].first.name).to eq(task2.name)
        end
      end

      context "by state" do
        it "assigns @tasks" do
          user = create(:user)
          task1 = create(:task, user: user)
          task2 = create(:task, user: user)
          session[:user_id] = user.id
          task2.update(state: "finish")

          get :index, params: { state: "finish" }

          expect(assigns[:tasks].first.name).to eq(task2.name)
        end
      end
    end

    context "order by priority" do
      context "order by desc" do
        it "assigns @tasks" do
          user = create(:user)
          task1 = create(:task, user: user)
          task2 = create(:task, user: user)
          session[:user_id] = user.id
          task2.update(priority: 2)

          get :index, params: { order_by: "priority", order_time: "desc" }

          expect(assigns[:tasks]).to eq([task2, task1])
        end
      end
      context "order by asc" do
        it "assigns @tasks" do
          user = create(:user)
          task1 = create(:task, user: user)
          task2 = create(:task, user: user)
          session[:user_id] = user.id
          task2.update(priority: 2)

          get :index, params: { order_by: "priority", order_time: "asc" }

          expect(assigns[:tasks]).to eq([task1, task2])
        end
      end
    end

    context "order by created_at" do
      context "order by desc" do
        it "assigns @tasks" do
          user = create(:user)
          task1 = create(:task, user: user)
          task2 = create(:task, user: user)
          session[:user_id] = user.id

          get :index, params: { order_by: "created_at", order_time: "desc" }

          expect(assigns[:tasks]).to eq([task2, task1])
        end
      end
      context "order by asc" do
        it "assigns @tasks" do
          user =  create(:user)
          task1 = create(:task, user: user)
          task2 = create(:task, user: user)
          session[:user_id] = user.id

          get :index, params: { order_by: "created_at", order_time: "asc" }

          expect(assigns[:tasks]).to eq([task1, task2])
        end
      end
    end

    context "order by finish_time" do
      context "order by desc" do
        it "assigns @tasks" do
          user = create(:user)
          task1 = create(:task, user: user)
          task2 = create(:task, user: user)
          session[:user_id] = user.id
          task2.update(finish_time: DateTime.now)

          get :index, params: { order_by: "finish_time", order_time: "desc" }

          expect(assigns[:tasks]).to eq([task2, task1])
        end
      end

      context "order by asc" do
        it "assigns @tasks" do
          user = create(:user)
          task1 = create(:task, user: user)
          task2 = create(:task, user: user)
          session[:user_id] = user.id
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
    context "when user loging" do
      it "assigns new @task" do
        user = create(:user)
        task = build(:task)

        session[:user_id] = user.id

        get :new

        expect(assigns[:task]).to be_a_new(Task)
      end

      it "render page new" do
        user = create(:user)
        task = build(:task)

        session[:user_id] = user.id
        get :new

        expect(response).to render_template("new")
      end
    end

    context "when user not loging" do
      it "redirect to login page" do
        user = create(:user)
        task = build(:task)
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "Post create" do
    context "when user login" do
      it "create new task" do
        user = create(:user)
        task = create(:task)
        session[:user_id] = user.id
        expect do
          post :create, params: { :task => attributes_for(:task)}
        end.to change{ Task.count }.by(1)
      end

      it "success redirect to tasks_path" do
        user = create(:user)
        task = create(:task)
        session[:user_id] = user.id
        post :create, params: { :task => attributes_for(:task)}
        expect(response).to redirect_to tasks_path
      end

      it "fail redirect to new_task_path" do
        user = create(:user)
        task = create(:task)
        session[:user_id] = user.id
        post :create, params: { :task => { content: "" }}
        expect(response).to render_template(:new)
      end
    end

    context "when user not login" do
      it "redirect to login page" do
        user = create(:user)
        task = create(:task)
        post :create, params: { :task => attributes_for(:task)}
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET edit" do
    context "when user login" do
      it "find and assigns @task" do
        user = create(:user)
        task = create(:task)
        session[:user_id] = user.id
        get :edit, params: { :id => task.id }
        expect(assigns[:task]).to eq(task)
      end

      it "render page edit" do
        user = create(:user)
        task = create(:task)
        session[:user_id] = user.id
        get :edit, params: { :id => task.id }
        expect(response).to render_template("edit")
      end
    end

    context "when user not login" do
      it "redirect to login page" do
        user = create(:user)
        task = create(:task)
        get :edit, params: { :id => task.id }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "Put update" do
    context "when user login" do
      it "update task" do
        user = create(:user)
        task = create(:task)
        session[:user_id] = user.id
        put :update, params: { id: task.id, task: { name: "321", content: "789"}}
        expect(assigns[:task].name).to eq("321")
        expect(assigns[:task].content).to eq("789")
      end

      it "redirect to index" do
        user = create(:user)
        task = create(:task)
        session[:user_id] = user.id
        put :update, params: { id: task.id, task: { name: "321", content: "789"}}
        expect(response).to redirect_to tasks_path
      end
    end
    context "when user not login" do
      it "redirect to login page" do
        user = create(:user)
        task = create(:task)
        put :update, params: { id: task.id, task: { name: "321", content: "789"}}
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "Delete destory" do
    context "when user login" do
      it "delete a record" do
        user = create(:user)
        task = create(:task)
        session[:user_id] = user.id
        expect { delete :destroy, params: { id: task.id }}.to change { Task.count }.by(-1)
      end

      it "redirect to index" do
        user = create(:user)
        task = create(:task)
        session[:user_id] = user.id
        delete :destroy, params: { id: task.id }
        expect(response).to redirect_to tasks_path
      end
    end

    context "when user not login" do
      it "delete a record" do
        user = create(:user)
        task = create(:task)
        expect { delete :destroy, params: { id: task.id }}.to change { Task.count }.by(0)
      end
    end
  end
end
