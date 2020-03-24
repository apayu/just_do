require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET new" do
    it "assigns @user" do
      get :new
      expect(assigns[:user]).to be_a_new(User)
    end

    it "render user new page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    it "create a new user" do
      user = create(:user)
      post :create, params: { user: attributes_for(:user)}
    end
    it "success redirect to tasks_path" do
    end
    it "fail render new page" do
    end
  end
end
