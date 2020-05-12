#  spec/requests/youtube/youtube_request_spec.rb

require "rails_helper"

RSpec.describe "Youtube Videos" do

  describe "Youtube Video Request" do

    it "can get a list of 3 videos" do
      user = create(:user)
      article_1 = create(:article, user_id: user.id)
      article_2 = create(:article, user_id: user.id)
      # article_comment = create(:comment, commentable_id: article_1.id, commentable_type: "Article", user_id: user.id)
      # podcast = create(:podcast)
      # podcast_episode = create(:podcast_episode, podcast_id: podcast.id)
      # podcast_comment = create(:comment, commentable_id: podcast_episode.id, commentable_type: "PodcastEpisode", user_id: user.id)
      last_article = create(:article, user_id: user.id)
      tags = last_article.cached_tag_list

      get "/#{user.username}/videos/youtube?tags=#{tags}"

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:attributes][:videos].length).to eq 3
    end

  end

end
