require "rails_helper"

RSpec.describe "Youtube Videos" do

  describe "Youtube Video Request" do

    it "can get a list of 3 videos", :vcr do
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

  end

end
