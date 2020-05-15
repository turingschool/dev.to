class MachineCollectionsController < ApplicationController
  def index
    @collections = MachineCollection.all.includes([:taggings]).format_data
    render json: @collections
  end

  def show
    @tags = MachineCollection.find(params[:id]).format
    render json: @tags
  end
end
