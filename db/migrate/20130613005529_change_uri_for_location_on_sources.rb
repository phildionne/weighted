class ChangeUriForLocationOnSources < ActiveRecord::Migration
  def change
    rename_column :sources, :uri, :location
  end
end
