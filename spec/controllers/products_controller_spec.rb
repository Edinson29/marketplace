require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  login_user
  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "validates that the published product is included" do
      product = create(:product, status: 'published')
      expect(controller.instance_variable_get(:@products)).to include(product)
    end

    it "validates that the unpublished product is not included" do
      product = create(:product, status: 'unpublished')
      expect(controller.instance_variable_get(:@products)).not_to include(product)
    end

    it "renders with index view" do
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
        user = create(:user)
        category = create(:category)
        post :create, params: { product: { name: 'kiwi', description: 'Producto muy poco conocido', quantity: 2, price: 6000, user_id: user.id, category_id: category.id } }
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

    it 'attaches the upload file' do
      file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
      user = create(:user)
      category = create(:category)
      expect {
        post :create, params: { product: { name: 'Guanabana', description: 'No es de gusto de todos', quantity: '1', price: 8989, user_id: user.id, category_id: category.id, images_attributes: [ { avatar: file } ]  } }
      }.to change(ActiveStorage::Attachment, :count).by(1)
    end
  end

  describe "GET #show" do
    before do
      @product = create(:product)
      get :show, params: { id: @product.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "renders with show view" do
      expect(response).to render_template("products/show")
    end

    it "assigns an instance @product with a show Product" do
      expect(controller.instance_variable_get(:@product)).to eq(@product)
    end
  end

  describe "GET #edit" do
    before do
      @product = create(:product)
      get :edit, params: { id: @product.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders to the edit view" do
      expect(response).to render_template("products/edit")
    end

    it "assigns an instance @product to a edit Product" do
      expect(controller.instance_variable_get(:@product)).to eq(@product)
    end
  end

  describe "PUT #update" do
    before do
      @product = create(:product)
    end

    it "validates updated parameters" do
      put :update, params: { id: @product.id, product: { name: 'Brocoli', description: 'Saludable y bueno para la cara', quantity: 6, price: 5680 } }
      expect(controller.instance_variable_get(:@product)).to have_attributes(name: 'Brocoli', description: 'Saludable y bueno para la cara', quantity: 6, price: 5680)
    end

    it "redirects to @product with valid first_name parameter" do
      put :update, params: { id: @product.id, product: { name: 'Atun' } }
      expect(response).to redirect_to product_path(@product)
    end

    context "renders to the edit view for invalid parameters" do
      it "renders for name empty" do
        put :update, params: { id: @product.id, product: { name: '' } }
        expect(response).to render_template("products/edit")
      end

      it "renders for description empty" do
        put :update, params: { id: @product.id, product: { description: '' } }
        expect(response).to render_template("products/edit")
      end

      it "renders for quantity empty" do
        put :update, params: { id: @product.id, product: { quantity: '' } }
        expect(response).to render_template("products/edit")
      end

      it "renders for price empty" do
        put :update, params: { id: @product.id, product: { price: '' } }
        expect(response).to render_template("products/edit")
      end
    end
  end

  describe "my products" do
    before do
      @product = create(:product)
      get :my_products
    end

    it "renders to my_products_path" do
      expect(response).to render_template 'my_products'
    end

    it "assigns an instance @my_products to a my_products Product" do
      expect(controller.instance_variable_get(:@my_products)).not_to eq(@product)
    end
  end

  describe "PUT #archived" do
    before do
      @product = FactoryBot.create(:product)
      put :archived, params: { id: @product.id }
    end

    it "changes to the archived status" do
      expect(Product.find_by(id: @product.id)).to have_attributes(status: 'archived')
    end

    it "renders to my_products" do
      expect(response).to redirect_to my_products_path
    end

    it "responds with 302" do
      expect(response).to have_http_status(302)
    end
  end

  describe "PUT #publish" do
    before do
      @product = FactoryBot.create(:product)
      put :publish, params: { id: @product.id }
    end

    it "changes to the archived status" do
      expect(Product.find_by(id: @product.id)).to have_attributes(status: 'published')
    end

    it "renders to my_products" do
      expect(response).to redirect_to my_products_path
    end

    it "responds with 302" do
      expect(response).to have_http_status(302)
    end
  end

  describe "PUT #publish" do
    before do
      @product = FactoryBot.create(:product)
      put :unpublish, params: { id: @product.id }
    end

    it "changes to the archived status" do
      expect(Product.find_by(id: @product.id)).to have_attributes(status: 'unpublished')
    end

    it "renders to my_products" do
      expect(response).to redirect_to my_products_path
    end

    it "responds with 302" do
      expect(response).to have_http_status(302)
    end
  end

  describe "validating before action" do
    it { should use_before_action(:set_product) }

    it { should use_before_action(:authenticate_user!) }
  end
end
