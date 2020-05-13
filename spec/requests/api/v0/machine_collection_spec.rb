require "rails_helper"

RSpec.describe "Api::V0::MachineCollections" do
  it "can get all machine_collections" do
    user = create(:user, username: "ben", summary: "Something something")
    user.machine_collections.create!(title: "Best of JS")
    user.machine_collections.create!(title: "Best of Ruby")

    get "/api/v0/machine_collections"

    expect(response).to be_successful

    collections = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(collections.count).to eq(2)
  end

  it "can get one machine_collection by its ID" do
    user = create(:user, username: "ben", summary: "Something something")
    collection1 = user.machine_collections.create!(title: "Best of JS")
    user.machine_collections.create!(title: "Best of Ruby")
    id = collection1.id

    get "/api/v0/machine_collections/#{id}"

    expect(response).to be_successful

    collection = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(collection[:id].to_i).to eq(id)
  end

  it "can update a machine_collection's title" do
    user = create(:user, username: "ben", summary: "Something something")
    collection1 = user.machine_collections.create!(title: "Best of JS")
    id = collection1.id
    previous_title = MachineCollection.last.title
    collection_params = { title: "Alex Rules, JS Drools" }

    patch "/api/v0/machine_collections/#{id}", params: collection_params

    collection = MachineCollection.find_by(id: id)

    expect(response).to be_successful
    expect(collection.title).not_to eq(previous_title)
    expect(collection.title).to eq("Alex Rules, JS Drools")
  end

  it "can delete a machine_collection" do
    user = create(:user, username: "ben", summary: "Something something")
    collection1 = user.machine_collections.create!(title: "Best of JS")
    user.machine_collections.create!(title: "Best of Ruby")

    expect(MachineCollection.count).to eq(2)

    delete "/api/v0/machine_collections/#{collection1.id}"

    expect(response).to be_successful
    expect(MachineCollection.count).to eq(1)
    expect { MachineCollection.find(collection1.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
