require "rails_helper"

RSpec.describe "Articles Youtube Section" do

  describe "Youtube Video Section on Articles Show View" do

    it "can show a heading and description of related videos." do
      user = create(:user)
      article_1 = create(:article, user_id: user.id)
      article_2 = create(:article, user_id: user.id)
      last_article = create(:article, user_id: user.id)
      tags = last_article.cached_tag_list
      description = last_article.description
      title = last_article.title

      visit "/#{user.username}"

      expect(page).to have_content(article_1.title)
      expect(page).to have_content(article_2.title)
      expect(page).to have_content(last_article.title)

      click_on(last_article.title)

      expect(page).to have_content('Related Videos')
      expect(page).to have_content("The videos below are based on the following.")
      expect(page).to have_content("Tags: #{tags}")
      expect(page).to have_content("Description: #{description}")
      expect(page).to have_content("Title: #{title}")
    end

  end

end
