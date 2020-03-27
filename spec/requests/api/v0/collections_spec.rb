require "rails_helper"

RSpec.describe "Api::V0::Articles", type: :request do
  describe "GET /api/:user_id/collections" do
    let(:user) { create(:user) }

    before do
      create_list(:machine_collection, 5, user_id: user.id)
    end

    it "returns a list of collections and their titles" do
      get "/api/#{user.id}/collections"

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data].length).to eq(5)
      expect(parsed[:data].first[:attributes][:title]).to eq("Collection-1")
      expect(parsed[:data].first[:attributes][:slug]).not_to eq(nil)
      expect(parsed[:data].first[:attributes][:cached_tag_list]).not_to eq(nil)
    end
  end
end
