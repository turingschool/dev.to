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
    {
      name: params[:name], user: current_user
    }
  end
end

# articles = Article.joins(:tags).where("tags.name = JavaScript").where("articles.created_at BETWEEN ? AND ?",Time.now-1.weeks,Time.now)

# Timeframe values from Timeframer::DATETIMES
# def top_articles_by_timeframe(timeframe:)
#   published_articles_by_tag.where("published_at > ?", Timeframer.new(timeframe).datetime).
#     order("score DESC").page(@page).per(@number_of_articles)
# end

# def latest_feed
# published_articles_by_tag.order("published_at DESC").
# where("featured_number > ? AND score > ?", 1_449_999_999, -40).
# page(@page).per(@number_of_articles)
# end
