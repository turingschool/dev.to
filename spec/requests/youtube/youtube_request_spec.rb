require "rails_helper"

RSpec.describe "Youtube Videos" do

  describe "Youtube Video Request" do

    it "can get a list of 3 videos from tags", :vcr do
      user = create(:user)
      article_1 = create(:article, user_id: user.id)
      article_2 = create(:article, user_id: user.id)
      last_article = create(:article, user_id: user.id)
      tags = last_article.cached_tag_list

      expect(tags.class).to eq(String)

      tags1 = "love, peace"
      get "/#{user.username}/videos/youtube?tags=#{tags1}"

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:type]).to eq ("youtube")
      expect(parsed_response[:data][:attributes][:videos].length).to eq 3
      expect(parsed_response[:data][:attributes][:videos].first[:id]).to_not be_empty
    end

    it "can get a list of 3 videos from description", :vcr do
      user = create(:user)
      article_1 = create(:article, user_id: user.id)
      article_2 = create(:article, user_id: user.id)
      last_article = create(:article, user_id: user.id)
      description = last_article.description

      expect(description.class).to eq(String)

      description1 =  "Post-ironic beard wes anderson franzen 90's. Authentic +1 kickstarter.  Chillwave roof kickstarter ch..."
      get "/#{user.username}/videos/youtube?description=#{description1}"

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:type]).to eq ("youtube")
      expect(parsed_response[:data][:attributes][:videos].length).to eq 3
      expect(parsed_response[:data][:attributes][:videos].first[:id]).to_not be_empty
    end

    it "can get a list of 3 videos from title", :vcr do
      user = create(:user)
      article_1 = create(:article, user_id: user.id)
      article_2 = create(:article, user_id: user.id)
      last_article = create(:article, user_id: user.id)
      title = last_article.title

      expect(title.class).to eq(String)

      title1 = "Gone with the Wind9"
      get "/#{user.username}/videos/youtube?title=#{title1}"

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:type]).to eq ("youtube")
      expect(parsed_response[:data][:attributes][:videos].length).to eq 3
      expect(parsed_response[:data][:attributes][:videos].first[:id]).to_not be_empty
    end

    it "can get a list of 3 videos with title, description and tags", :vcr do
      user = create(:user)
      article_1 = create(:article, user_id: user.id)
      article_2 = create(:article, user_id: user.id)
      last_article = create(:article, user_id: user.id)
      tags = last_article.cached_tag_list
      title = last_article.title
      description = last_article.description

      tags1 = "distillery"
      description1 = "Come by our distillery to try out our distilled beverages. It is a haven for lovers of quality brew."
      title1 = "Distillery Tour"

      get "/#{user.username}/videos/youtube?tags=#{tags1}&description=#{description1}&title=#{title1}"

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:type]).to eq ("youtube")
      expect(parsed_response[:data][:attributes][:videos].length).to eq 3
      expect(parsed_response[:data][:attributes][:videos].first[:id]).to_not be_empty
    end

  end

end
