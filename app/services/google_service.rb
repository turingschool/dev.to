class GoogleService
  def self.youtube_videos(keywords)
    new.youtube_videos(keywords)
  end

  def youtube_videos(keywords)
    json = get_json("/youtube/v3/search",
                    part: "snippet",
                    q: keywords,
                    maxResults: 18)
    json[:items]
  end

  def self.video_data(video_ids)
    new.video_data(video_ids)
  end

  def video_data(video_ids)
    json = get_json("/youtube/v3/videos",
                    part: "statistics",
                    id: video_ids)
    json[:items]
  end

  private

  def get_json(uri, parameters)
    response = conn.get(uri) do |req|
      req.params = req.params.merge(parameters)
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(
      url: "https://www.googleapis.com",
      params: { key: ENV["GOOGLE_API_KEY"] },
    )
  end
end
