require "rails_helper"

RSpec.describe "Machine Collections", type: :request do
  let(:user) { create(:user) }
  let(:tag1)  { create(:tag) }
  let(:tag2)  { create(:tag) }


  describe "get index page machine_collections/index" do
    it "returns rss+xml content" do
      sign_in user
      create(:article, tags: %w[ruby preact rails])
      create(:article, tags: %w[ruby preact rails])
      create(:article, tags: %w[rails preact heroku])
      tags = [tag1, tag2]
      # x = user.machine_collections.create!(
      #   title: 'Mountain Shelter',
      #   tags: %w[ruby preact rails]
      # )
      get "/machinecollections"
      require "pry"; binding.pry
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
    end
  end
end
