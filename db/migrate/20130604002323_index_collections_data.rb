class IndexCollectionsData < ActiveRecord::Migration
  def change
    add_hstore_index :collections, :data
  end
end
