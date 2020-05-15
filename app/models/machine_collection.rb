class MachineCollection < ApplicationRecord
  # allows us to use .tag_list method on a machine collection to see what tags it has
  acts_as_taggable_on :tags

  belongs_to :user
  validates :title, presence: true

  def self.format_data
    MachineCollection.all.map do |collection|
      { title: collection.title, tag_list: collection.tag_list }
    end
  end
end
