require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "responds with 200" do
      get :new
      expect(response).to have_http_status(200)
    end

    it "responds with view new" do
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
end
