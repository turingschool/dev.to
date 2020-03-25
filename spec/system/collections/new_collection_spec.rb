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
    expect(page).to have_css("#collection_tags")
  end
end
