class MachineCollection < ApplicationRecord
  # allows us to use .tag_list method on a machine collection to see what tags it has
  acts_as_taggable_on :tags

  belongs_to :user
  validates :title, presence: true
end
