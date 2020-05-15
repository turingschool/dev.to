require "rails_helper"

describe "Machine Collections" do
  let(:user) { create(:user) }
  let(:tag1) { create(:tag) }
  describe "render machine collection new page" do
    it "can visit the new page" do
      visit "/machinecollections/new"
      expect(current_path).to eq( "/machinecollections/new")
    end
    
  end
end
