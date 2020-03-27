class AddIndexOnSlugReadingCollection < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :reading_collections, :slug, algorithm: :concurrently
  end
end
