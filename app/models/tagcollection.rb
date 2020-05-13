class Tagcollection < ApplicationRecord
  validates :name, presence: true
  belongs_to :user, :dependent

  acts_as_taggable_on :tags
end
