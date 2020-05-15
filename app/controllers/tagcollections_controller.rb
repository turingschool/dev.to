class TagcollectionsController < ApplicationController
  def index
    @tagcollection = current_user.tagcollections.all.to_json
  end

  def create
    tagcollection = current_user.tagcollections.create(tagcollection_params)
    tagcollection.to_json
  end

  # def show
  #
  # end

  private

  def tagcollection_params
    params["tagcollection"].permit(:name, :tag_list)
  end
end
