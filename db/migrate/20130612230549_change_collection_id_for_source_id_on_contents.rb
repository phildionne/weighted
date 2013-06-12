class ChangeCollectionIdForSourceIdOnContents < ActiveRecord::Migration
  def change
    rename_column :contents, :collection_id, :source_id
  end
end
