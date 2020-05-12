require "rails_helper"

RSpec.describe MachineCollectionArticle, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to :machine_collection }
    it { is_expected.to belong_to :article }
  end
end
