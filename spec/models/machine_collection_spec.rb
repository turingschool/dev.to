require "rails_helper"

RSpec.describe MachineCollection, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :tag_list }
  end

  describe "relationships" do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :machine_collection_articles }
    it { is_expected.to have_many(:articles).through(:machine_collection_articles) }
  end

  describe "methods" do
    let(:user) { create(:user) }

    it "can get machine generated articles" do
      create_list(:article, 4, user: user, featured: true, tags: ["javascript"])
      create_list(:article, 4, user: user, featured: true, tags: ["react"])
      mach_col = described_class.create(title: "Intro to Frontend Development", tag_list: %w[javascript react], user_id: user.id)
      expect(mach_col.suggested_articles.count).to eq(8)
    end
  end
end
