class YoutubeFacade
  attr_reader :keywords, :id

  def initialize(params)
    @id = nil
    @params = params
  end

  def videos
    youtube_service.videos.map do |data|
      Youtube.new(data)
    end
  end

  private

  def youtube_service
    @service = YoutubeService.new(@params)
  end
end
