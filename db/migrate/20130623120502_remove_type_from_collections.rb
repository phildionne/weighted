class RemoveTypeFromCollections < ActiveRecord::Migration
  def delete
    remove_column :collections, :type
  end
end
