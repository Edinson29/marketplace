module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryBot.create(:user)
    end
  end

  def logout_user
     before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_out FactoryBot.create(:user)
    end
  end
end
