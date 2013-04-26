class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :stripe_card_token
      t.integer :customer_id

      t.timestamps
    end
  end
end
