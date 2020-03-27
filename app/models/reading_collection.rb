class ReadingCollection < ApplicationRecord
  belongs_to :user
  has_many :reading_collection_articles, dependent: :destroy
  has_many :articles, through: :reading_collection_articles

  validates :name, :user_id, presence: true
  acts_as_taggable_on :tags

  def get_articles
    Article.where("created_at >= ?", 1.week.ago).
      tagged_with(tag_list, any: true).
      order("page_views_count DESC").
      limit(10)
  end
end
