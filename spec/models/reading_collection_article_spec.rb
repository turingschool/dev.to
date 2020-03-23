require "rails_helper"

RSpec.describe ReadingCollectionArticle, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to :article }
    it { is_expected.to belong_to :reading_collection }
  end
end
