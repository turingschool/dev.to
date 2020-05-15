require "rails_helper"

RSpec.describe ArticleTagcollection, type: :model do
  describe "validations" do
    it { is_expected.to belong_to(:article) }
    it { is_expected.to belong_to(:tagcollection) }
  end
end
