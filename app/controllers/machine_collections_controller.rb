class MachineCollectionsController < ApplicationController
  def index
    data = MachineCollection.all.includes([:taggings])
    @collections = data.format_data.to_json
  end
end
