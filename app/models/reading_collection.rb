class ReadingCollection < ApplicationRecord
  belongs_to :user
  has_many :reading_collection_articles, dependent: :destroy
  has_many :articles, through: :reading_collection_articles
  validates :name, :user_id, presence: { presence: true }
  validates :slug, presence: true, format: /\A[0-9a-z\-_]*\z/, uniqueness: { scope: :user_id }
  before_validation :set_slug

  private

  def set_slug
    # same way they are setting slugs elsewhere in the app
    self.slug = name.to_s.downcase.parameterize.tr("_", "") + "-" + rand(100_000).to_s(26)
  end

  has_many :reading_collection_tags
  has_many :tags, through: :reading_collection_tags
  validates :name, :user_id, presence: true

  def get_articles(tags)
    self.articles = tags.map do |t|
      Article.cached_tagged_with(t).first
    end.to_a
  end
end
