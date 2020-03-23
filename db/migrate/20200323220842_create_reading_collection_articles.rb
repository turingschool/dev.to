class CreateReadingCollectionArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :reading_collection_articles do |t|
      t.references :article, foreign_key: true
      t.references :reading_collection, foreign_key: true

      t.timestamps
    end
  end
end
