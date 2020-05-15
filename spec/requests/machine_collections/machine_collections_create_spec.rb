require "rails_helper"

RSpec.describe "Machine Collections", type: :request do
  let(:user) { create(:user) }
  let(:tag1)  { create(:tag) }
  let(:tag2)  { create(:tag) }
  let(:tag3)  { create(:tag) }

  describe "get index page machine_collections/index" do
    it "can create a collection with post route " do
      create_list(:article, 2, user: user, featured: true, tags: ["Ruby"])
      create_list(:article, 10, user: user, featured: true, tags: ["Javascript"])
      sign_in user
      collection_params = { title: "Ruby Collection", tag_list: %w[Ruby Javascript] }
      post "/machinecollections", params: collection_params
      expect(response.status).to eq(302)
      expect(response.content_type).to eq("text/html")
    end

    it "rejects create a collection without all params  " do
      sign_in user
      collection_params = { title: "Ruby Collection" }
      post "/machinecollections", params: collection_params
      expect(response.status).to eq(302)
      expect(response.content_type).to eq("text/html")
    end
  end
end
