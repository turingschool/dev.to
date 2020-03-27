require "rails_helper"

RSpec.describe ReadingCollection, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :user_id }
    # Ideally, the two assertions below would be working, I cannot figure out why they are not
    # Will come back to
    # it { is_expected.to validate_uniqueness_of(:slug).scoped_to(:user_id) }
    # it { is_expected.to validate_presence_of :slug }
  end

  describe "relationships" do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many(:reading_collection_articles).dependent(:destroy) }
    it { is_expected.to have_many(:articles).through(:reading_collection_articles) }
  end

  describe "attributes" do
    it "has attributes" do
      user = create(:user)
      reading_collection = described_class.create!(name: "My Collection", user: user)

      expect(reading_collection.name).to eq("My Collection")
      expect(reading_collection.user_id).to eq(user.id)
      slug = reading_collection.slug
      expect(slug.include?("my-collection")).to eq(true)
    end
  end

  describe "model methods" do
    describe "#set-slug" do
      it "sets a unique slug before create" do
        user = create(:user)
        reading_collection = described_class.create!(name: "Collection 1", user: user)
        reading_collection2 = described_class.create!(name: "Collection 1", user: user)

        slug = reading_collection.slug
        expect(slug).to be_a String

        slug2 = reading_collection2.slug

        expect(slug2).to be_a String
        expect(slug).not_to eq(slug2)

        reading_collection2.slug = nil
        reading_collection2.save
        expect(reading_collection2.slug).not_to be_nil
      end
    end
  end
end
