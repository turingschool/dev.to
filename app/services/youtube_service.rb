class YoutubeService
  attr_reader :tags, :keywords

  def initialize(params)
    @tags = params[:tags]
    @title = params[:title]
    @description = params[:description]
  end

  def videos
    results = get_json(@tags)
    results = get_json(@description) if results[:items].empty?
    results = get_json(@title) if results[:items].empty?
    results[:items]
  end

  private

  def get_json(search_params)
    @response ||= conn(search_params).get
    JSON.parse(@response.body, symbolize_names: true)
  end

  def conn(search_params)
    Faraday.new("https://www.googleapis.com/youtube/v3/search") do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV["YOUTUBE_API_KEY"]
      f.params[:q] = search_params
      f.params[:part] = "snippet"
      f.params[:type] = "video"
      f.params[:videoEmbeddable] = "true"
      f.params[:maxResults] = "3"
    end
  end
end
