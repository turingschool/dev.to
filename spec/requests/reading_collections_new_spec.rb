require "rails_helper"

RSpec.describe "Reading Collections Create", type: :request do
  let(:user) { create(:user) }
  let(:separate_user) { create(:user) }
  let(:article) { create(:article, user_id: separate_user.id) }
  let(:article2) { create(:article, user_id: separate_user.id) }
  let(:article3) { create(:article, user_id: separate_user.id) }

  before do
    article2.tag_list.remove(article2.tag_list[0])
    article2.tag_list.remove(article2.tag_list[0])
    article2.tag_list.remove(article2.tag_list[0])
    article2.tag_list.remove(article2.tag_list[0])
    article3.tag_list.add(article.tag_list[0])
    sign_in user
  end

  it "creates reading collection with proper params" do
    name = "Reading Collection"
    post "/api/reading_collections", params: {
      name: name,
      tag_list: [article.tag_list[0], article3.tag_list[1]]
    }
    reading_collection = ReadingCollection.last
    expect(reading_collection.user_id).to eq(user.id)
    expect(reading_collection.articles.count).to eq(2)
  end
end
