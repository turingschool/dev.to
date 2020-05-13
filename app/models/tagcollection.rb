class Tagcollection < ApplicationRecord
  validates :name, presence: true
  belongs_to :user

  acts_as_taggable_on :tags
end
