ActiveAdmin.register User do
  permit_params :first_name,
                :last_name,
                :email,
                :cellphone,
                :address,
                :password,
                :password_confirmation

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :cellphone
      f.input :address
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :email, :cellphone, :address, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
