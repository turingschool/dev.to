require "rails_helper"

RSpec.describe MachineCollection, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:cached_tag_list) }
    it { is_expected.to validate_presence_of(:title) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:user) }
  end

  describe "create_slug" do
    let(:user) { create(:user) }

    it "generates a random slug string" do
      machine_collection = described_class.create(title: "Javascript Collection", user_id: user.id, cached_tag_list: "javascript")

      expect(machine_collection.slug).not_to eq(nil)
    end
  end

  describe "articles_past_seven_days" do
    let(:user) { create(:user) }

    it "returns a collection of articles that are tagged with the collection's tag from the past seven days" do
      javascript_machine_collection = described_class.create(title: "Javascript Collection", user_id: user.id, cached_tag_list: "javascript")
      ruby_machine_collection = described_class.create(title: "Ruby Articles Collection", user_id: user.id, cached_tag_list: "ruby")

      eight_days_ago = Time.zone.today - 8.days

      create_list(:article, 3, tags: "discuss, javascript, security")
      create_list(:article, 2, tags: "react, ruby")
      create_list(:article, 2, tags: "javascript, computerscience, beginners, ruby")
      create_list(:article, 3, tags: "javascript", created_at: eight_days_ago)
      create_list(:article, 3, tags: "ruby", created_at: eight_days_ago)

      expect(javascript_machine_collection.articles_past_seven_days.length).to eq(5)
      expect(ruby_machine_collection.articles_past_seven_days.length).to eq(4)
    end
  end
end
