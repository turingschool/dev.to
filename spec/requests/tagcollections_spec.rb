require "rails_helper"

RSpec.describe "Tagcollections", type: :request do
  let(:user) { create(:user) }
  let(:separate_user) { create(:user) }
  let(:article) { create(:article, user_id: user.id) }
  let(:reaction) { create(:reaction, reactable: article, user_id: user.id) }
  let(:unauthorized_reaction) { create(:reaction, reactable: article, user_id: separate_user.id) }

  before do
    sign_in user
  end

  describe "GET /mycollections" do
    it "successfully routes to /tagcollections" do
      get "/tagcollections"

      expect(response).to have_http_status(:ok)
    end

    xit "navigates by links to my collections" do
    end
  end
end
