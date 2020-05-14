class MachineCollectionsController < ApplicationController
  def index
    @collections = MachineCollection.all
  end
end
