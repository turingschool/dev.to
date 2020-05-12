require "rails_helper"

RSpec.describe "Tagcollections", type: :request do
  before do
    user = create(:user)
    # tagcollection = @user.tagcollections.create(name: "All the Ruby", tag_list: ['ruby'])
    sign_in user
  end

  it "successfully routes to /tagcollections" do
    get "/tagcollections"

    expect(response).to have_http_status(:ok)
  end

  # xit "navigates by links to my collections" do
  #
  # end
end
