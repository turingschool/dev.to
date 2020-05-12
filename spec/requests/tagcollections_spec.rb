require "rails_helper"

RSpec.describe "Tagcollections", type: :request do
  describe "GET /mycollections" do
    it "successfully routes to /tagcollections" do
      get "/tagcollections"

      expect(response).to have_http_status(:ok)
    end

    # xit "navigates by links to my collections" do
    #
    # end
  end
end
