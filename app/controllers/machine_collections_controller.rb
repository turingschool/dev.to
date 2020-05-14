class MachineCollectionsController < ApplicationController

  before_action :authenticate_user!, except: %i[feed new]

  def index
    @machine_collections = logged_in_user.machine_collections
  end

  def show
    @machine_collection = logged_in_user.machine_collections.find(params[:id])
  end

  def new
  end

private

  def machine_collection_params
    allowed_params = %i[title user_id tag_list]
    params.require(:machine_collections).permit(allowed_params)
  end

  def logged_in_user
    current_user
  end

end
