class AddChachedTagListToCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :cached_tag_list, :string
  end
end
