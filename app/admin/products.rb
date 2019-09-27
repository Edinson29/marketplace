ActiveAdmin.register Product do
  permit_params :name,
                :description,
                :quantity,
                :price,
                :user_id,
                :status,
                :category_id,
                images_attributes: %i[id avatar _destroy]

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :quantity
      f.input :price
      f.input :user_id, as: :select, collection: User.all
      f.input :status
      f.input :category_id, as: :select, collection: Category.all
      f.inputs do
        f.has_many :images, new_record: true,
                            allow_destroy: true do |a|
          a.input :avatar, as: :file
        end
      end
    end
    f.actions
  end
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :quantity, :price, :user_id, :status, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
