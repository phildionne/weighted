class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :gravatar_email
      t.string :first_name
      t.string :last_name
      t.string :avatar

      t.timestamps
    end
  end
end
