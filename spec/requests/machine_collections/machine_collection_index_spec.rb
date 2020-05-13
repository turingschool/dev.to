require "rails_helper"

RSpec.describe "Machine Collections", type: :request do
  let(:user) { create(:user) }
  let(:tag1)  { create(:tag) }
  let(:tag2)  { create(:tag) }


  describe "get index page machine_collections/index" do
    it "User can visit thier machine colleciton index" do
      sign_in user
      user.machine_collections.create!(title: "Ruby collection")
      create(:article, tags: %w[ruby java rails])
      create(:article, tags: %w[ruby javascript rails])
      create(:article, tags: %w[rails preact])
      user.machine_collections.first.articles << Article.all
      get "/machinecollections"
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
    end
  end
end
