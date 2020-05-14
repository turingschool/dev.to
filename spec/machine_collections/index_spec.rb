require "rails_helper"

RSpec.describe "as a visitor", type: :feature do
  let(:user) { create(:user) }

  it "can show a machine_collections index page" do
    user.machine_collections.create!(title: "Javascript stuff", tag_list: %w[Java Javascript])
    user.machine_collections.create!(title: "Ruby stuff", tag_list: %w[Ruby Rails])

    visit "/machine_collections"

    expect(page).to have_css(".home")
    expect(page).to have_css("#machine-collections")
  end
end
