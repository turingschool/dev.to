require "rails_helper"

RSpec.describe ReadingCollection, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :user_id }
  end

  describe "relationships" do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many(:reading_collection_articles).dependent(:destroy) }
    it { is_expected.to have_many(:articles).through(:reading_collection_articles) }
  end

  describe "Model methods" do
    describe "#get_articles" do
      it "gets articles for the reading collection based on selected tags" do
        user = create(:user)

        reading_collection = user.reading_collections.create(name: "Git Collection", tag_list: %w[git linux])

        create(:article, page_views_count: 34, tags: %w[java react sql])
        create(:article, page_views_count: 45, tags: %w[git react sql], created_at: "Fri, 28 Feb 2020 13:30:25 SAST +02:00")
        article3 = create(:article, page_views_count: 2, tags: %w[git linux])
        article4 = create(:article, page_views_count: 23, tags: %w[java react linux git])
        article5 = create(:article, page_views_count: 100, tags: %w[java react git])

        expected = [article5, article4, article3]
        expect(reading_collection.get_articles.to_a).to eq(expected)
      end
    end
  end
end
