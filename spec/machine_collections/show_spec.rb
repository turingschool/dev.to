require "rails_helper"

RSpec.describe "as a visitor", type: :feature do
  let(:user) { create(:user) }

  it "can see one of their machine collections" do
    collection1 = user.machine_collections.create!(title: "Javascript stuff", tag_list: %w[Java Javascript])
    user.machine_collections.create!(title: "Ruby stuff", tag_list: %w[Ruby Rails])

    visit "/machine_collections/#{collection1.id}"

    expect(page).to have_css(".home")
    expect(page).to have_css("#machine-collection")
  end
end
