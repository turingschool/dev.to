require "rails_helper"

RSpec.describe MachineCollection, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :tags }
  end

  describe "relationships" do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :tags }
  end
end
