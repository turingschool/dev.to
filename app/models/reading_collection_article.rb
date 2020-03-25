class ReadingCollectionArticle < ApplicationRecord
  belongs_to :article
  belongs_to :reading_collection
end
