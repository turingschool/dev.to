class ArticleTagcollection < ApplicationRecord
  belongs_to :article
  belongs_to :tagcollection
end
