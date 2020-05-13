class Tagcollection < ApplicationRecord
  validates :name, presence: true
  belongs_to :user, presence: true

  acts_as_taggable_on :tags
end
