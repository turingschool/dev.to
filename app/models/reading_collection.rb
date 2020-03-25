class ReadingCollection < ApplicationRecord
  belongs_to :user
  has_many :reading_collection_articles, dependent: :destroy
  has_many :articles, through: :reading_collection_articles

  has_many :reading_collection_tags
  has_many :tags, through: :reading_collection_tags

  validates :name, :user_id, presence: true
end
