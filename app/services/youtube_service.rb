class YoutubeService
  attr_reader :keywords

  def initialize(keywords)
    @keywords = keywords
  end

  def videos
    get_json[:items]
  end

  private

  def get_json
    @response ||= conn.get
    JSON.parse(@response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://www.googleapis.com/youtube/v3/search") do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV["YOUTUBE_DATA_KEY"]
      f.params[:q] = keywords
      f.params[:part] = "snippet"
      f.params[:type] = "video"
      f.params[:videoEmbeddable] = "true"
      f.params[:maxResults] = "50"
    end
  end
end
