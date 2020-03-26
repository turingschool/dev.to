require "rails_helper"

RSpec.describe "new collection" do
  let(:user) { create(:user) }

  before do
    sign_in user
    create_list(:tag, 5)
  end

  it "user sees field to input title and select tags" do
    visit "/#{user.id}/collections/new"

    expect(page).to have_css("#collection_title")
    expect(page).to have_css("#tag_name")
  end

  it "user can fill in a collection title and select tag to follow then submit new collection" do
    visit "/#{user.id}/collections/new"

    fill_in "collection_title", with: "Javascript Collection"
    select("tag7", from: "tag_name").select_option

    click_on "Create Collection"

    expect(page).to have_current_path("/readinglist")
  end
end
