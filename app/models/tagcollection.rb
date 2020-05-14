class Tagcollection < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :article_tagcollections
  has_many :articles, through: :article_tagcollections

  acts_as_taggable_on :tags
end
