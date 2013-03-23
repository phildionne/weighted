class CreateCollectionSourceJoinTable < ActiveRecord::Migration
  def change
    create_table :collections_sources, id: false do |t|
      t.integer :collection_id
      t.integer :source_id
    end
  end
end
