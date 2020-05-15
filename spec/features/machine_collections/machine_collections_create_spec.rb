require "rails_helper"

describe "Machine Collections" do
  let(:user) { create(:user) }
  let(:tag1) { create(:tag) }
  describe "render machine collection new page" do
    it "can get one of its collections" do
      visit "/machinecollections/new"
    end
  end
end
