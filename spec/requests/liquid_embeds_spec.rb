require "rails_helper"

VCR_OPTIONS = {
  cassette_name: "twitter_fetch_status",
  allow_playback_repeats: true
}.freeze

RSpec.describe "LiquidEmbeds", type: :request, vcr: VCR_OPTIONS do
  describe "get /embeds" do
    it "renders proper tweet" do
      get "/embed/tweet?args=1018911886862057472"
      expect(response.body).to include("ltag__twitter-tweet")
    end

    it "renders 404 if improper tweet" do
      expect do
        get "/embed/tweet?args=improper"
      end.to raise_error(ActionView::Template::Error)
    end

    it "contains base target parent" do
      get "/embed/tweet?args=1018911886862057472"
      expect(response.body).to include('<base target="_parent">')
    end
  end
end
