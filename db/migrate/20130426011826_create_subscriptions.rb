class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :stripe_customer_id
      t.string :stripe_card_last4
      t.string :state
      t.belongs_to :user

      t.timestamps
    end
  end
end
