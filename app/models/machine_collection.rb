class MachineCollection < ApplicationRecord
  before_validation :create_slug
  validates :cached_tag_list, :title, presence: true
  belongs_to :user

  def create_slug
    self.slug = title.to_s.downcase.parameterize.tr("_", "") + "-" + rand(100_000).to_s(26)
  end

  def articles_past_seven_days
    Article.where("position('#{cached_tag_list}' in cached_tag_list) > 0").
      where("created_at > '#{Time.zone.today - 7.days}'")
  end
end
