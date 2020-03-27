class ReadingCollectionsController < ApplicationController
  def new
    # will complete when refactoring partial
  end

  def create
    reading_collection = ReadingCollection.create(collection_params)
    rc_tags = params["tags"]
    reading_collection.get_articles(rc_tags)
    redirect_to "/readinglist"
  end

  private

  def collection_params
    { name: params[:name], user: current_user }
  end
end

# articles = Article.joins(:tags).where("tags.name = JavaScript").where("articles.created_at BETWEEN ? AND ?",Time.now-1.weeks,Time.now)
