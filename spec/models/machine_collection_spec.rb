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
end
