class RelevantContentController < ApplicationController
  def create
    content = RelevantContentFacade.new(params[:keywords])
    render json: RelevantContentSerializer.new(content)
  end
end
