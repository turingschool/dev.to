class YoutubeVideo
  attr_reader :kind,
              :etag,
              :video_id,
              :published_at,
              :title,
              :description,
              :thumbnail_url,
              :thumbnail_width,
              :thumbnail_height,
              :channel_id,
              :channel_title

  def initialize(data)
    @kind = data[:kind]
    @etag = data[:etag]
    @video_id = data[:id][:videoId]
    @published_at = data[:snippet][:publishedAt]
    @title = data[:snippet][:title]
    @description = data[:snippet][:description]
    @thumbnail_url = data[:snippet][:thumbnails][:high][:url]
    @thumbnail_width = data[:snippet][:thumbnails][:high][:width]
    @thumbnail_height = data[:snippet][:thumbnails][:high][:height]
    @channel_id = data[:snippet][:channelId]
    @channel_title = data[:snippet][:channelTitle]
  end
end
