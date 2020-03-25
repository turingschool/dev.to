require "rails_helper"

RSpec.describe "Relevant Content", :vcr do
  describe "YouTube Video Request" do
    it "can get a list of 50 youtube videos" do
      keywords = "westworld robots"

      post "/relevant_content?keywords=#{keywords}"
      expect(response).to be_successful
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
