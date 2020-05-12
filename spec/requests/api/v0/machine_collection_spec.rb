require "rails_helper"

RSpec.describe "Api::V0::MachineCollections" do
  it "can get all collections" do
    user = create(:user, username: "ben", summary: "Something something")
    user.machine_collections.create!(title: "Best of JS")
    user.machine_collections.create!(title: "Best of Ruby")
  end
end
