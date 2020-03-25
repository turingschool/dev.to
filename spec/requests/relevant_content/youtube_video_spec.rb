require "rails_helper"

RSpec.describe "Relevant Content" do
  describe "YouTube Video Request" do
    it "can get a list of 50 youtube videos" do
      WebMock.disable!
      keywords = "westworld robots"

      post "/relevant_content?keywords=#{keywords}"
      expect(response).to be_successful
      JSON.parse(response.body, symbolize_names: true)
      WebMock.enable!
    end
  end
end
