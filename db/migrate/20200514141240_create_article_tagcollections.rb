class CreateArticleTagcollections < ActiveRecord::Migration[5.2]
  def change
    create_table :article_tagcollections do |t|
      t.references :tagcollection, foreign_key: true
      t.references :article, foreign_key: true
    end
  end
end
