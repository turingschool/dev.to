class AddSlugToReadingCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :reading_collections, :slug, :string
  end
end
