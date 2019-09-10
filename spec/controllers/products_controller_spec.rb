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

  describe "GET #new" do
    before do
      get :new
    end

    it "responds with 200" do
      expect(response).to have_http_status(200)
    end

    it "responds with new view" do
      expect(response).to render_template("products/new")
    end

    it "assins an intansce @user with new user" do
      expect(controller.instance_variable_get(:@product)).to be_a_new(Product)
    end
  end

  describe "POST #create" do
    context "When @product.save is true" do
      it "return 302" do
        post :create, params: { product: { name: 'kiwi', description: 'Producto muy poco conocido', quantity: 2, price: 6000, user_id: 3 } }
        expect(response).to have_http_status(302)
      end
    end

    context "when @product.save is false" do
      it "renders for name empty" do
        post :create, params: { product: { name: '', description: 'Es unafruta muy dulce', quantity: '6', price: 3000 } }
        expect(response).to render_template(:new)
      end

      it "renders for description empty" do
        post :create, params: { product: { name: 'Manzana', description: '', quantity: '4', price: 2000 } }
        expect(response).to render_template(:new)
      end

      it "renders for quantity empty" do
        post :create, params: { product: { name: 'Guanabana', description: 'No es de gusto de todos', quantity: '', price: 7000 } }
        expect(response).to render_template(:new)
      end

      it "renders for price empty" do
        post :create, params: { product: { name: 'Guanabana', description: 'No es de gusto de todos', quantity: '1', price: '' } }
        expect(response).to render_template(:new)
      end
    end

    context 'when a param is not included in the strong param require' do
      it "doesn't affects the User" do
        date = Date.parse('1955-01-01')
        post :create, params: { product: { name: 'piña', description: 'Da un sabor exquisito a la pizza', quantity: 1, price: 6500, created_at: date } }
        expect(User.last.created_at.to_date).not_to eq(date)
      end
    end
  end
end
