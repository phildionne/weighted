class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.text :body
      t.string :source
      t.belongs_to :collection

      t.timestamps
    end
  end
end
