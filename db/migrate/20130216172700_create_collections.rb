class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :subject
      t.string :description

      t.timestamps
    end
  end
end
