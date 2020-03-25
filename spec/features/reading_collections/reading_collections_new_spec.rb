require "rails_helper"
require "pry"

RSpec.describe ReadingCollection do
  describe "as a user when i visit /readinglist", type: :feature do
    it "i can create a new reading collection" do
      user = create(:user)
      described_class.create(user: user, name: "Name")

      create(:tag, name: "JavaScript")
      # uncomment below line to pass test
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit "/readinglist"

      expect(page).to have_content("Reading List")
      expect(page).to have_content("Name")

      within(".home") do
        within("#reading-collections") do
          fill_in "Name", with: "Phil's Collection"
          click_button("Create Collection")
        end
      end

      expect(page).to have_current_path("/readinglist")
      expect(described_class.count).to eq(2)
    end
  end
end
