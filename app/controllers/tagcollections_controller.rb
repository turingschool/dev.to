class TagcollectionsController < ApplicationController
  def index
    @tagcollection = current_user.tagcollections.all.to_json
  end

  # def show
  #
  # end
  # def create
  # end
end
