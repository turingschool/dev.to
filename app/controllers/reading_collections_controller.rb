class ReadingCollectionsController < ApplicationController
  def new
    # uncomment later
  end

  def create
    ReadingCollection.create(collection_params)
    redirect_to "/readinglist"
  end

  private

  def collection_params
    {
      name: params[:name], user: current_user
    }
  end
end
