class YoutubeFacade
  attr_reader :keywords, :id

  def initialize(tags)
    @id = nil
    @tags = tags
  end

  def videos
    youtube_service.videos.map do |data|
      Youtube.new(data)
    end
  end

  private

  def youtube_service
    @service = YoutubeService.new(@tags)
  end
end
