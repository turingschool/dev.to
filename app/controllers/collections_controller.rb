class CollectionsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @tags = Tag.all
  end
end
