class ReadingCollectionArticle < ApplicationRecord
  belongs_to :article
  belongs_to :readingcollection
end
