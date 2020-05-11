class CreateParlaimentArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :parlaiment_articles do |t|
      t.references :parlaiment, foreign_key: true
      t.references :article, foreign_key: true
    end
  end
end
