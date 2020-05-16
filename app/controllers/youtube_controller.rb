class YoutubeController < ApplicationController
  def index
    videos = YoutubeFacade.new(params)
    render json: YoutubeSerializer.new(videos)
  end
end
