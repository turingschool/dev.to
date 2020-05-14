class Api::V0::MachineCollectionsController < ApplicationController
  def index
    render json: MachineCollectionSerializer.new(MachineCollection.all.includes(:taggings))
  end

  def show
    render json: MachineCollectionSerializer.new(MachineCollection.find(params[:id]))
  end

  def update
    render json: MachineCollectionSerializer.new(MachineCollection.update(machine_collection_params))
  end

  def destroy
    render json: MachineCollectionSerializer.new(MachineCollection.destroy(params[:id]))
  end
end

private

def machine_collection_params
  params.permit(:title, :user_id, tag_list: [])
end
