class CreateCollectionSourceJoinTable < ActiveRecord::Migration
  def change
    create_table :collections_sources, id: false do |t|
      t.belongs_to :collection
      t.belongs_to :source
    end
  end
end
