class MachineCollection < ApplicationRecord
  before_validation :create_slug
  validates :cached_tag_list, :title, presence: true
  belongs_to :user

  def create_slug
    self.slug = title.to_s.downcase.parameterize.tr("_", "") + "-" + rand(100_000).to_s(26)
  end
end
