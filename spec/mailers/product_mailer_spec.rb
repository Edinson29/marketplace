require "rails_helper"
RSpec.describe ProductMailer, type: :mailer do
  describe "notify" do
    before do
      @user = build(:user)
      @product = build(:product, user_id: @user.id)
    end

    let(:mail) { ProductMailer.published_product(@user, @product)}
    context "renders the headers" do
      it "renders the subject" do
        expect(mail.subject).to eq('New published product')
      end

      it "renders the to" do
        expect(mail.to).to eq([@user.email])
      end

      it "renders the from" do
        expect(mail.from).to eq(['admin@marketplace.com'])
      end
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello, there is a new product published")
    end
  end
end
