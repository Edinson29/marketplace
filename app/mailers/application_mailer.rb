class ApplicationMailer < ActionMailer::Base
  include 'products_controller'
  default from: 'example@email.com'
  layout 'mailer'
  def published_product(product)
    @product = product
    if publish
      User.all.each do |user|
        mail(to: user.email, subject: 'New published product')
      end
    end
  end
end
