require "rails_helper"

class FakeDelegator < ActionMailer::MessageDelivery
  # TODO: we should replace all usage of .deliver to .deliver_now
  def deliver(*args)
    super
  end
end

RSpec.describe DailyDigestEmail, type: :labor do
  let(:user) { create(:user, email_daily_digest_notifications: true) }
  let(:author) { create(:user) }
  let(:mock_delegator) { instance_double("FakeDelegator") }

  before do
    allow(DailyDigestMailer).to receive(:daily_digest_email) { mock_delegator }
    allow(mock_delegator).to receive(:deliver).and_return(true)
    user
  end

  context "when daily digest email" do
    before { user.follow(author) }

    it "sendemail based on highest page view count" do
      article = create(:article, user_id: author.id, page_views_count: 50)
      article2 = create(:article, user_id: user.id, page_views_count: 50)
      article3 = create(:article, user_id: author.id, page_views_count: 40)

      described_class.send_daily_digest_email

      expect(DailyDigestMailer).to have_received(:daily_digest_email).with(
        user, article
      )

      expect(DailyDigestMailer).not_to have_received(:daily_digest_email).with(
        user, article2
      )

      expect(DailyDigestMailer).not_to have_received(:daily_digest_email).with(
        user, article3
      )
    end
  end
end
