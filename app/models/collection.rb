class Collection < ApplicationRecord
  # We will need to create a new model cooresponding to
  # our new table, it will validate the presence of title
  # and tags and have the many to many relationship with articles
  has_many :articles
  belongs_to :user
  belongs_to :organization, optional: true

  validates :user_id, presence: true
  validates :slug, presence: true, uniqueness: { scope: :user_id }

  after_touch :touch_articles

  def self.find_series(slug, user)
    Collection.find_or_create_by(slug: slug, user: user)
  end

  def touch_articles
    articles.update_all(updated_at: Time.zone.now)
  end
end
