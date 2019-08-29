class ChangeIntegerLimitInYourTable < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :cellphone, :integer, limit: 8
  end
end
