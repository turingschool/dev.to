require "rails_helper"

RSpec.describe Tagcollection, type: :model do
  describe "validations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:article_tagcollections) }
    it { is_expected.to have_many(:articles).through(:article_tagcollections) }
  end
end
