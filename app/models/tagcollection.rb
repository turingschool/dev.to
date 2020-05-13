class Tagcollection < ApplicationRecord
  validates :name, presence: true
  belongs_to :user, optional: true

  acts_as_taggable_on :tags
end
