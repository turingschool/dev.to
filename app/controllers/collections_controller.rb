class CollectionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.find(params[:user_id])
    @tags = Tag.all
  end

  def create
    @collection = Collection.new(title: collection_params[:collection_title], user_id: collection_params[:user_id])
    if @collection.save
      redirect_to "/readinglist"
    else
      render :new
    end
  end

  private

  def collection_params
    params.permit(:collection_title, :tag, :user_id)
  end
end
