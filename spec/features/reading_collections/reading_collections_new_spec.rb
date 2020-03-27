require "rails_helper"
require "pry"

RSpec.describe ReadingCollection do
  describe "as a user when i visit /readinglist", type: :system do
    let_it_be(:user) { create(:user) }

    before do
      sign_in user
      described_class.create(user: user, name: "Phil's Collection")
      create_list(:article, 10)
      visit "/readinglist"
    end

    it "i can create a new reading collection" do
      article = create(:article)

      within(".home") do
        within("#reading-list") do
          fill_in "Name", with: "Second Collection"
          find(:css, "#tags_[value=#{article.cached_tag_list.split(', ').first}]").set(true)
          find(:css, "#tags_[value=#{article.cached_tag_list.split(', ').second}]").set(true)
          click_button("Create Collection")
        end
      end

      expect(page).to have_current_path("/readinglist")
      expect(described_class.count).to eq(2)
      expect(Article.count).to eq(11)
      expect(described_class.last.articles.count).to eq(2)
    end
  end
end
