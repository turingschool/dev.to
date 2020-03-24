require "rails_helper"

describe GoogleService, type: :service do
  context "when class methods" do
    context "when videos" do
      it "can return a list of Youtube videos based on keywords/tags supplied", :vcr do
        youtube_videos = described_class.youtube_videos("linux, go, beginners")

        expect(youtube_videos).to be_a Hash
        expect(youtube_videos[:items]).to be_an Array
        expect(youtube_videos[:items].count).to eq(10)
        expect(youtube_videos[:items][0].keys).to eq(%i[kind etag id snippet])
        expect(youtube_videos[:items][0][:id].keys).to eq(%i[kind videoId])
        expect(youtube_videos[:items][0][:snippet].keys).to eq(%i[publishedAt channelId title description thumbnails channelTitle liveBroadcastContent])
        expect(youtube_videos[:items][0][:snippet][:thumbnails].keys).to eq(%i[default medium high])
      end
    end
  end
end
