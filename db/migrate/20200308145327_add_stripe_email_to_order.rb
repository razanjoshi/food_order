class AddStripeEmailToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :stripe_email, :string
  end
end
