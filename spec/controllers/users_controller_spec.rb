require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "responds with new view" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #create" do
    it "vale" do
      post :create, params: { user: { first_name: 'edinson',last_name: 'gutierrez', email: 'edinsongutie@hotmail.com', cellphone: 3265565, address: 'chinita' } }
      expect(subject).to redirect_to assigns(:user)
    end
  end
end
