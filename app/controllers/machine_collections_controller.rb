class MachineCollectionsController < ApplicationController
  def index
    @collections = MachineCollection.all.includes(:taggings).format_data.to_json
  end
end
