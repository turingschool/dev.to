class Api::V0::MachineCollectionsController < ApplicationController
  def index
    user = User.find(params[:user_id])

    collections = user.machine_collections

    render json: MachineCollectionSerializer.new(collections)
  end
end
