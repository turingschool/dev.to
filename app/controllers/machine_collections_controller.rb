class MachineCollectionsController < ApplicationController

  before_action :authenticate_user!, except: %i[feed new]

  def index
    require "pry"; binding.pry
    render :json
  end

  def machine_collection_params
   params.require(:user).permit(:name, :tag_list)
  end

end
