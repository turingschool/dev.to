class CollectionListItemsController < ApplicationController
  # creating a new class, ReadingListItemsController, which inherets from ApplicationController
  def index
    # creates method on class called index
    @collection_list_items_index = true
    # setting instance variable readling_list_items_index to true
    set_view
    # runs set_view method seen below
    generate_algolia_search_key
    # runs method seen below
  end
  # finishes index method

  def update
    @reaction = Reaction.find(params[:id])
    # creates instance variable that can find a reaction based on its id from the Reaction model
    not_authorized if @reaction.user_id != session_current_user_id
    # this line will block the action if the user id associated in the session is different from the user id recieved from the reaction variable
    @reaction.status = params[:current_status] == "archived" ? "valid" : "archived"
    # determines if a reaction has been archived or valid
    @reaction.save
    # run the save method on reaction (is this a built in method)
    head :ok
    # returns a response header to the browser
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
