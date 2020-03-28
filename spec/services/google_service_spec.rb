require "rails_helper"

describe GoogleService, type: :service do
  context "when class methods" do
    context "when videos", :vcr do
      it "can return a list of Youtube videos based on keywords/tags supplied" do
        youtube_videos = described_class.youtube_videos("linux, go, beginners")

        expect(youtube_videos).to be_an Array
        expect(youtube_videos.count).to eq(18)
        expect(youtube_videos[0].keys).to eq(%i[kind etag id snippet])
        expect(youtube_videos[0][:id].keys).to eq(%i[kind videoId])
        expect(youtube_videos[0][:snippet].keys).to eq(%i[publishedAt channelId title description thumbnails channelTitle liveBroadcastContent])
        expect(youtube_videos[0][:snippet][:thumbnails].keys).to eq(%i[default medium high])
      end

      it "can return statistics for a list of videos by video id" do
        youtube_videos = described_class.youtube_videos("linux, go, beginners")
        video_ids = youtube_videos.map { |video| video[:id][:videoId] }
        video_ids.compact!
        id_string = video_ids.join(",")
        video_data = described_class.video_data(id_string)

        expect(video_data).to be_an Array
        expect(video_data.count).to eq(video_ids.count)
        expect(video_data[0].keys).to eq(%i[kind etag id statistics])
        expect(video_data[0][:statistics].keys).to eq(%i[viewCount likeCount dislikeCount favoriteCount commentCount])
      end
    end
  end
end
