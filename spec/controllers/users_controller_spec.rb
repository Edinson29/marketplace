require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user
  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "assigns an instance @users with a index User" do
      expect(controller.instance_variable_get(:@users)).to eq(User.order("id ASC"))
    end

    it "renders with index view" do
      expect(response).to render_template("index")
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
      expect(response).to render_template("new")
    end

    it "assigns an instance @user with a new User" do
      expect(controller.instance_variable_get(:@user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context 'when @user.save is true' do
      it "returns 302" do
        post :create, params: { user: { first_name: 'edinson',last_name: 'gutierrez', email: 'edinsongutie@hotmail.com', password: '98765432', password_confirmation: '98765432', cellphone: 3265565, address: 'chinita' } }
        expect(response).to have_http_status(302)
      end

      it "redirects to users" do
        post :create, params: { user: { first_name: 'efrain', last_name: 'castro', email: 'vidachevere@gmail.com', password: '12345678', password_confirmation: '12345678', cellphone: 3568545, address: 'ciudadela' } }
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

    it "redirects to @user with valid first_name parameter" do
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

  describe "DELETE #destroy" do
    before do
      @user = create(:user)
    end

    it "redirects to users_path" do
      delete :destroy, params: { id: @user.id }
      expect(response).to redirect_to users_path
    end

    it "is not include the deleted user" do
      delete :destroy, params: { id: @user.id }
      expect(User.all).not_to include(@user)
    end
  end

  it "has a current user" do
    expect(subject.current_user).not_to eq(nil)
  end

  describe "validating with logout_user" do
    logout_user
    it "should have a current_user" do
      expect(subject.current_user).to eq(nil)
    end
  end
end
