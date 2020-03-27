require "rails_helper"

RSpec.describe "Views a collection", type: :system do
  let_it_be(:user) { create(:user) }
  let_it_be(:article_1, reload: true) { create(:article, :with_notification_subscription, user: user) }
  let_it_be(:article_2, reload: true) { create(:article, :with_notification_subscription, user: user) }
  let_it_be(:article_3, reload: true) { create(:article, :with_notification_subscription, user: user) }
  let_it_be(:reading_collection) { create(:reading_collection, user: user) }
  let_it_be(:reading_collection2) { create(:reading_collection, user: user) }

  before do
    user.reading_collections.first.articles << [article_1, article_2, article_3]
    sign_in user
    visit "/readingcollections/#{reading_collection.slug}"
  end

  it "shows a reading collection" do
    expect(page).to have_content(reading_collection.name)
    expect(page).not_to have_content(reading_collection2.name)
  end

  it "shows the articles associated with the collection" do
  end
end
