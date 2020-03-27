class ReadingListItemsController < ApplicationController
  def index
    @reading_list_items_index = true
    @reading_collections = ReadingCollection.where(user_id: session_current_user_id).to_json
    # Article.joins(:taggings).joins(:tags).select("articles.*").where("tags.name = 'javascript'")
    # Article.joins(:tags).where("tags.name = 'javascript'")
    # Article.joins(:tags).where("tags.name = 'javascript'").where("articles.created_at < ?", 2.days.ago)
    # Article.joins(:tags).where("tags.name = 'javascript'").where("articles.created_at BETWEEN ? AND ?",Time.now-2.weeks,Time.now)
    set_view
    generate_algolia_search_key
  end

  def update
    @reaction = Reaction.find(params[:id])
    not_authorized if @reaction.user_id != session_current_user_id

    @reaction.status = params[:current_status] == "archived" ? "valid" : "archived"
    @reaction.save
    head :ok
  end

  private

  def generate_algolia_search_key
    params = { filters: "viewable_by:#{session_current_user_id}" }
    @secured_algolia_key = Algolia.generate_secured_api_key(
      ApplicationConfig["ALGOLIASEARCH_SEARCH_ONLY_KEY"], params
    )
  end

  def set_view
    @view = if params[:view] == "archive"
              "archived"
            else
              "valid"
            end
  end
end
