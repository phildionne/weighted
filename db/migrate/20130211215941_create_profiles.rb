class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :provider_avatar
      t.string :gravatar_email
      t.string :name
      t.string :first_name
      t.string :last_name
      t.belongs_to :user

      t.timestamps
    end
  end
end
