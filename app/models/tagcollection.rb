class Tagcollection < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :article_tagcollections
  has_many :articles, through: :article_tagcollections

  acts_as_taggable_on :tags

  def find_articles
    self.articles = Article.tagged_with(tag_list, any: true).order(page_views_count: :desc).limit(5)
  end
end
