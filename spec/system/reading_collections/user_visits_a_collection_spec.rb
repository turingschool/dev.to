require "rails_helper"

RSpec.describe "Views a collection", type: :system do
  let_it_be(:user) { create(:user) }
  let_it_be(:article_1, reload: true) { create(:article, :with_notification_subscription, user: user) }
  let_it_be(:article_2, reload: true) { create(:article, :with_notification_subscription, user: user) }
  let_it_be(:article_3, reload: true) { create(:article, :with_notification_subscription, user: user) }
  # let(:timestamp) { "2019-03-04T10:00:00Z" }
  let_it_be(:reading_collection) { create(:reading_collection, user: user) }

  before do
    user.reading_collections.first.articles << [article_1, article_2, article_3]
    sign_in user
    # visit "/readingcollections/#{article.slug}"
  end

  it "shows an article" do
    expect(page).to have_content(article.title)
  end
end
