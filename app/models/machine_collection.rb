class MachineCollection < ApplicationRecord
  validates :cached_tag_list, :slug, :title, presence: true
  belongs_to :user
end
