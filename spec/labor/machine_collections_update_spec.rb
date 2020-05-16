require "rails_helper"

RSpec.describe UpdateMachineCollections, type: :labor do
  let(:user) { create(:user) }
  it "updates all machine collections" do
    article1 = create(:article, tags: %w[Ruby])
    article2 = create(:article, tags: %w[Javascript])
    machine_collection_1 = user.machine_collections.create!({
      title: "A Cool Collection",
      tag_list: %w[Ruby Javascript React]
      })
    machine_collection_2 = user.machine_collections.create!({
      title: "A Fun Ruby Collection",
      tag_list: %w[Ruby]
      })
    machine_collection_3 = user.machine_collections.create!({
      title: "A Silly JS Collection",
      tag_list: %w[Javascript]
      })
    machine_collection_3.articles << article2
    machine_collection_2.articles << article1
    expect(machine_collection_3.articles.count).to eq(1)
    expect(machine_collection_2.articles.count).to eq(1)
    create_list(:article, 500, user: user, featured: true, tags: ["Ruby"])
    create_list(:article, 10, user: user, featured: true, tags: ["Javascript"])
    UpdateMachineCollections.new
    expect(machine_collection_3.articles.count).to eq(11) #10 articles + the first article they orginially had
    expect(machine_collection_2.articles.count).to eq(11)
    end
  end
