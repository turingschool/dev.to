require "rails_helper"

RSpec.describe ReadingCollection, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :user_id }
  end

  describe "relationships" do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :reading_collection_articles }
    it { is_expected.to have_many(:articles).through(:reading_collection_articles) }
  end
end
