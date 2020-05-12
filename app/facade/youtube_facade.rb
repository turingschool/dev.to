class YoutubeFacade
  attr_reader :keywords, :id

  def initialize(keywords)
    @id = nil
    @keywords = keywords
  end

  def videos
    youtube_service.videos.map do |data|
      Youtube.new(data)
    end
  end

  private

  def youtube_service
    @service = YoutubeService.new(keywords)
  end
end
