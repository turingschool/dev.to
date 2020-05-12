class MachineCollection < ApplicationRecord
  belongs_to :user

  acts_as_taggable_on :tags

  validates :title, :tags, presence: true
end
