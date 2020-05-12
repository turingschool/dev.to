class YoutubeController < ApplicationController
  def index
    videos = YoutubeFacade.new(params[:tags])
    render json: YoutubeSerializer.new(videos)
  end
end
