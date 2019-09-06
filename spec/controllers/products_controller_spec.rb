require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns an instance @users with a index User" do
      get :index
      expect(controller.instance_variable_get(:@products)).to eq(Product.order("id ASC"))
    end

    it "renders with index view" do
      get :index
      expect(response).to render_template("products/index")
    end
  end
end
