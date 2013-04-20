class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.belongs_to :user
      t.belongs_to :collection

      t.timestamps
    end
    add_index :follows, :user_id
    add_index :follows, :collection_id
    add_index :follows, [:user_id, :collection_id], unique: true
  end
end
