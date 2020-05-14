class MachineCollection < ApplicationRecord
 belongs_to :user
 has_many :machine_collection_articles, dependent: :destroy
 has_many :articles, through: :machine_collection_articles

 acts_as_taggable_on :tags
 resourcify

 validates_presence_of :title, :tag_list
end
