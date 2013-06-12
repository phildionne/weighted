class CreateContentUserJoinTable < ActiveRecord::Migration
  def change
    create_table :contents_users, id: false do |t|
      t.belongs_to :content
      t.belongs_to :user
    end
  end
end
