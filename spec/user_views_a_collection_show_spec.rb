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
    valid_article_1 = create(:article, tags: "javascript", created_at: three_days_ago, page_views_count: 5)
    valid_article_2 = create(:article, tags: "javascript", created_at: three_days_ago, page_views_count: 15)
    valid_article_3 = create(:article, tags: "javascript", created_at: three_days_ago, page_views_count: 0)
    invalid_article_1 = create(:article, tags: "javascript", created_at: ten_days_ago)
    invalid_article_2 = create(:article, tags: "ruby", created_at: ten_days_ago)

    visit "/#{user.id}/collections/#{machine_collection.id}"

    expect(page).to have_content("Articles in #{machine_collection.title}")

    within ".machine_collection_articles" do
      expect(page.all('li')[0]).to have_content("Title: #{valid_article_2.title}")
      expect(page.all('li')[0]).to have_content("Page views: #{valid_article_2.page_views_count}")
      expect(page.all('li')[1]).to have_content("Title: #{valid_article_1.title}")
      expect(page.all('li')[1]).to have_content("Page views: #{valid_article_1.page_views_count}")
      expect(page.all('li')[2]).to have_content(valid_article_3.title)
      expect(page).to_not have_content("#{invalid_article_1.title}")
      expect(page).to_not have_content("#{invalid_article_2.title}")

      click_link "#{valid_article_2.title}"
    end

    expect(current_path).to eq("/#{valid_article_2.cached_user_username}/#{valid_article_2.slug}")
  end
end
