require "rails_helper"

RSpec.describe "Collection show page", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end


  it "diplays the title of each article in the collection" do
    three_days_ago = Time.zone.today - 3.days
    ten_days_ago = Time.zone.today - 10.days
    machine_collection = create(:machine_collection, user: user, cached_tag_list: "javascript", title: "Best of JavaScript")
    valid_article_1 = create(:article, tags: "javascript", created_at: three_days_ago)
    valid_article_2 = create(:article, tags: "javascript", created_at: three_days_ago)
    invalid_article = create(:article, tags: "javascript", created_at: ten_days_ago)
    
    visit "/#{user.id}/collections/#{machine_collection.slug}"

    expect(page).to have_css(".machine_collection_articles")
    expect(page).to have_content("Articles in #{machine_collection.title}")
    expect(page).to have_content("#{valid_article_1.title}")
    expect(page).to have_content("#{valid_article_2.title}")
    expect(page).to_not have_content("#{invalid_article.title}")
  end
end
