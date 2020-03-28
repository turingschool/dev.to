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
              :channel_title,
              :view_count,
              :like_count,
              :dislike_count,
              :favorite_count,
              :comment_count

  def initialize(data, statistics)
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
    @view_count = statistics[:statistics][:viewCount]
    @like_count = statistics[:statistics][:likeCount]
    @dislike_count = statistics[:statistics][:dislikeCount]
    @favorite_count = statistics[:statistics][:favoriteCount]
    @comment_count = statistics[:statistics][:commentCount]
  end
end
