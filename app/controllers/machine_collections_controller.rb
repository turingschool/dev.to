class MachineCollectionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.find(params[:user_id])
    @tags = Tag.all
  end

  def create
    @collection = MachineCollection.new(title: collection_params[:collection_title], cached_tag_list: collection_params[:name], user_id: collection_params[:user_id])
    if @collection.save
      redirect_to "/readinglist"
    else
      @user = User.find(params[:user_id])
      @tags = Tag.all
      flash[:alert] = @collection.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @collection = MachineCollection.find(params[:id])
    @collection_articles = @collection.articles_past_seven_days
  end

  private

  def collection_params
    tags = params[:tag].permit(:name)
    params.permit(:collection_title, :tag, :user_id).merge(tags)
  end
end
