require "rails_helper"
RSpec.describe "Machine Collections", type: :system do
  let(:user) { create(:user) }
  let(:tag1) { create(:tag) }

  describe "get index page machine_collections/index" do
    it "can get one of its collections" do
      visit machinecollections_new_path
    end
  end
end
