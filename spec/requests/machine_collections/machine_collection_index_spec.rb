# require "rails_helper"
#
# RSpec.describe "Machine Collections", type: :request do
#   let(:user) { create(:user) }
#   let(:tag1)  { create(:tag) }
#   let(:tag2)  { create(:tag) }
#
#   describe "get index page machine_collections/index" do
#     it "returns rss+xml content" do
#       tags = [tag1, tag2]
#       require "pry"; binding.pry
#       x = user.machine_collections.create!(
#         title: 'Mountain Shelter',
#         tags: tags
#       )
#       get "/feed"
#       expect(response.status).to eq(200)
#       expect(response.content_type).to eq("application/rss+xml")
#     end
#   end
# end
