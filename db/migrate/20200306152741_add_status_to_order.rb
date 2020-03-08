class AddStatusToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :status, :string
    add_column :orders, :address, :string
    add_column :orders, :phone, :string
    add_column :orders, :card_token, :string
  end
end
