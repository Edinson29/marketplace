class ProductMailer < ApplicationMailer
  def published_product(user,product)
    @product = product
    @user = user
    mail(to: @user.email, subject: 'New published product')
  end
end
