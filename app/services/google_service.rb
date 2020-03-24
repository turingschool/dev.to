class GoogleService
  def self.youtube_videos(keywords)
    new.youtube_videos(keywords)
  end

  def youtube_videos(keywords)
    json = get_json("/youtube/v3/search",
                    part: "snippet",
                    q: keywords,
                    maxResults: 10)

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
