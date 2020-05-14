class CreateMachineCollectionArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :machine_collection_articles do |t|
      t.references :machine_collection, foreign_key: true
      t.references :article, foreign_key: true
    end
  end
end
