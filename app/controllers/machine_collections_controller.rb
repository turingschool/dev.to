class MachineCollectionsController < ApplicationController
  def index
    @collections = MachineCollection.format_data
  end
end
