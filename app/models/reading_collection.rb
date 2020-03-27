class ReadingCollection < ApplicationRecord
  belongs_to :user
  has_many :reading_collection_articles, dependent: :destroy
  has_many :articles, through: :reading_collection_articles

  has_many :reading_collection_tags
  has_many :tags, through: :reading_collection_tags

  validates :name, :user_id, presence: true

  def get_articles(tags)
    self.articles = tags.map do |t|
      Article.where("articles.created_at BETWEEN ? AND ?", Time.zone.now - 1.week, Time.zone.now).order("positive_reactions_count DESC").cached_tagged_with(t)[0]
    end
  end
end
