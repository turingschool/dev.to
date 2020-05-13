class MachineCollectionsController < ApplicationController

  before_action :authenticate_user!, except: %i[feed new]

  def index
    @machine_collections = current_user.machine_collections
  end

private
  def machine_collection_params
   params.require(:user).permit(:name, :tag_list, :user_id)
  end

end
