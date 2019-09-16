require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET #index" do

    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders with index view" do
      expect(response).to render_template("categories/index")
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
      expect(response).to render_template("categories/new")
    end

    it "assins an instance @category with new category" do
      expect(controller.instance_variable_get(:@category)).to be_a_new(Category)
    end
  end

  describe "POST #create" do
    context "When @category.save is true" do
      it "return 302" do
        post :create, params: { category: { name: 'kiwi' } }
        expect(response).to have_http_status(302)
      end
    end

    context "when @category.save is false" do
      it "renders for name empty" do
        post :create, params: { category: { name: '' } }
        expect(response).to render_template(:new)
      end
    end

    context 'when a param is not included in the strong param require' do
      it "doesn't affects the Category" do
        date = Date.parse('1955-01-01')
        post :create, params: { category: { name: 'Favorites', created_at: date } }
        expect(User.last.created_at.to_date).not_to eq(date)
      end
    end
  end

  describe "GET #show" do
    before do
      @category = create(:category)
      get :show, params: { id: @category.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "renders with show view" do
      expect(response).to render_template("categories/show")
    end

    it "assigns an instance @category with a show category" do
      expect(controller.instance_variable_get(:@category)).to eq(@category)
    end
  end

  describe "GET #edit" do
    before do
      @category = create(:category)
      get :edit, params: { id: @category.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders to the edit view" do
      expect(response).to render_template("categories/edit")
    end

    it "assigns an instance @category to a edit category" do
      expect(controller.instance_variable_get(:@category)).to eq(@category)
    end
  end

  describe "PUT #update" do
    before do
      @category = create(:category)
    end

    it "validates updated parameters" do
      put :update, params: { id: @category.id, category: { name: 'Fiction' } }
      expect(controller.instance_variable_get(:@category)).to have_attributes(name: 'Fiction')
    end

    it "redirects to @category with valid first_name parameter" do
      put :update, params: { id: @category.id, category: { name: 'Atun' } }
      expect(response).to redirect_to category_path(@category)
    end

    context "renders to the edit view for invalid parameters" do
      it "renders for name empty" do
        put :update, params: { id: @category.id, category: { name: '' } }
        expect(response).to render_template("categories/edit")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @category = create(:category)
      delete :destroy, params: { id: @category.id }
    end

    it "redirects to categories_path" do
      expect(response).to redirect_to categories_path
    end

    it "is not include the deleted user" do
      expect(Category.all).not_to include(@category)
    end
  end

  describe "set_article use" do
    it { should use_before_action(:set_category) }
  end

end
