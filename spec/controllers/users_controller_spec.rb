require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns an instance @users with a index User" do
      get :index
      expect(controller.instance_variable_get(:@users)).to eq(User.all.sort)
    end

    it "renders with index view" do
      get :index
      expect(response).to render_template("users/index")
    end
  end

  describe "GET #new" do
    it "responds with 200" do
      get :new
      expect(response).to have_http_status(200)
    end

    it "responds with new view" do
      get :new
      expect(response).to render_template("users/new")
    end

    it "assigns an instance @user with a new User" do
      get :new
      expect(controller.instance_variable_get(:@user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context 'when @user.save is true' do
      it "returns 302" do
        post :create, params: { user: { first_name: 'edinson',last_name: 'gutierrez', email: 'edinsongutie@hotmail.com', cellphone: 3265565, address: 'chinita' } }
        expect(response).to have_http_status(302)
      end

      it "redirects to @user" do
        post :create, params: { user: { first_name: 'efrain', last_name: 'castro', email: 'vidachevere@gmail.com', cellphone: 3568545, address: 'ciudadela' } }
        expect(response).to redirect_to user_path(User.find_by(email: 'vidachevere@gmail.com'))
      end
    end

    context 'when @user.save is false' do
      describe "renders to the action new" do
        it "renders for first_name is empty" do
          post :create, params: { user: { first_name: '', last_name: 'figueroa', email: 'efigueroa@hotmail.com', cellphone: 3568545, address: 'ciudadela' } }
          expect(response).to render_template(:new)
        end

        it "renders for last_name is empty" do
          post :create, params: { user: { first_name: 'efrain', last_name: '', email: 'efrainf@hotmail.com', cellphone: 3568545, address: 'ciudadela' } }
          expect(response).to render_template(:new)
        end

        it "renders for email is empty" do
          post :create, params: { user: { first_name: 'efrain', last_name: 'castro', email: '', cellphone: 3568545, address: 'ciudadela' } }
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when a param is not included in the strong param require' do
      it "doesn't affects the User" do
        date = Date.parse('1955-01-01')
        post :create, params: { user: { first_name: 'efrain', last_name: 'castro', email: 'happyhappy@gmail.com', cellphone: 325648, address: 'ciudadela', created_at: date } }
        expect(User.last.created_at.to_date).not_to eq(date)
      end
    end
  end

  describe "GET #show" do
    it 'returns http success' do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it "renders with show view" do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response).to render_template("users/show")
    end

    it "assigns an instance @user with a show User" do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(controller.instance_variable_get(:@user)).to eq(user)
    end
  end

  describe "GET #edit" do
    before do
      @user = create(:user)
      get :edit, params: { id: @user.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders to the edit view" do
      expect(response).to render_template("users/edit")
    end
    it "assigns an instance @user to a edit User" do
      expect(controller.instance_variable_get(:@user)).to eq(@user)
    end
  end

  describe "PUT #update" do
    before do
      @user = create(:user)
    end

    it "validates updated parameters" do
      put :update, params: { id: @user.id, user: { first_name: 'Fabio', last_name: 'Altamar', email: 'falata@gmail.com', cellphone: 56890, address: 'Villa Campestre' } }
      expect(controller.instance_variable_get(:@user)).to have_attributes(first_name: 'Fabio', last_name: 'Altamar', email: 'falata@gmail.com', cellphone: 56890, address: 'Villa Campestre')
    end

    it "redirects to @user" do
      put :update, params: { id: @user.id, user: { first_name: 'Eugenio' } }
      expect(response).to redirect_to user_path(@user)
    end

    context "renders to the edit view for invalid parameters" do
      it "renders for first_name empty" do
        put :update, params: { id: @user.id, user: { first_name: '' } }
        expect(response).to render_template("users/edit")
      end

      it "renders for last_name empty" do
        put :update, params: { id: @user.id, user: { last_name: '' } }
        expect(response).to render_template("users/edit")
      end

      it "renders for email empty" do
        put :update, params: { id: @user.id, user: { email: '' } }
        expect(response).to render_template("users/edit")
      end
    end
  end
end
