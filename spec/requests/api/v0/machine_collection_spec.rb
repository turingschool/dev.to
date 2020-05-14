require "rails_helper"

RSpec.describe "Api::V0::MachineCollections" do
  it "can get all machine_collections" do
    user = create(:user, username: "ben", summary: "Something something")
    user.machine_collections.create!(title: "Best of JS", tag_list: %w[Java Javascript])
    user.machine_collections.create!(title: "Best of Ruby", tag_list: %w[Rails Ruby])

    get "/api/v0/machine_collections"

    expect(response).to be_successful
    collections = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(collections.count).to eq(2)
  end

  it "can get one machine_collection by its ID" do
    user = create(:user, username: "ben", summary: "Something something")
    collection1 = user.machine_collections.create!(title: "Best of JS", tag_list: %w[Java Javascript])
    user.machine_collections.create!(title: "Best of Ruby")

    get "/api/v0/machine_collections/#{collection1.id}"

    expect(response).to be_successful

    collection = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(collection[:attributes][:title]).to eq("Best of JS")
    expect(collection[:attributes][:tag_list].first).to eq("Java")
  end

  it "can update a machine_collection's title" do
    user = create(:user, username: "ben", summary: "Something something")
    collection1 = user.machine_collections.create!(title: "Best of JS", tag_list: %w[Java Javascript])

    collection_params = { title: "Alex Rules, JS Drools" }

    patch "/api/v0/machine_collections/#{collection1.id}", params: collection_params

    collection = MachineCollection.find(collection1.id)

    expect(response).to be_successful
    expect(collection.title).not_to eq("Best of JS")
    expect(collection.title).to eq("Alex Rules, JS Drools")
  end

  it "can update a collections tags" do
    user = create(:user, username: "ben", summary: "Something something")
    collection1 = user.machine_collections.create!(title: "Best of JS", tag_list: %w[Java Javascript])

    collection_params = { tag_list: %w[Rails Ruby] }

    patch "/api/v0/machine_collections/#{collection1.id}", params: collection_params

    collection = MachineCollection.find(collection1.id)

    expect(response).to be_successful
    expect(collection.tag_list.first).not_to eq("Java")
    expect(collection.tag_list.first).to eq("Rails")
    expect(collection.tag_list.last).not_to eq("Javascript")
    expect(collection.tag_list.last).to eq("Ruby")
  end

  it "can update a collections title and tags" do
    user = create(:user, username: "ben", summary: "Something something")
    collection1 = user.machine_collections.create!(title: "Best of JS", tag_list: %w[Java Javascript])

    collection_params = { title: "Best of Ruby", tag_list: %w[Rails Ruby] }

    patch "/api/v0/machine_collections/#{collection1.id}", params: collection_params

    collection = MachineCollection.find(collection1.id)

    expect(response).to be_successful
    expect(collection.title).not_to eq("Best of JS")
    expect(collection.title).to eq("Best of Ruby")
    expect(collection.tag_list.first).not_to eq("Java")
    expect(collection.tag_list.first).to eq("Rails")
    expect(collection.tag_list.last).not_to eq("Javascript")
    expect(collection.tag_list.last).to eq("Ruby")
  end

  it "can delete a machine_collection" do
    user = create(:user, username: "ben", summary: "Something something")
    collection1 = user.machine_collections.create!(title: "Best of JS", tag_list: %w[Java Javascript])
    user.machine_collections.create!(title: "Best of Ruby", tag_list: %w[Rails Ruby])

    expect(MachineCollection.count).to eq(2)

    delete "/api/v0/machine_collections/#{collection1.id}"

    expect(response).to be_successful
    expect(MachineCollection.count).to eq(1)
    expect { MachineCollection.find(collection1.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
