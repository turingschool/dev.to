require "rails_helper"

RSpec.describe MachineCollection, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:cached_tag_list) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:title) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:user) }
  end
end
