class ReadingCollectionsController < ApplicationController
  def show
    @collection = ReadingCollection.find_by(slug: params[:slug])
  end

  def new; end
end
