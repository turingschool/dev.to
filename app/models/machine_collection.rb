class MachineCollection < ApplicationRecord
  has_many :tags
  belongs_to :user
  validates :title, presence: true
end
