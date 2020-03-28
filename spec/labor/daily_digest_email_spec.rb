require "rails_helper"

class FakeDelegator < ActionMailer::MessageDelivery
  # TODO: we should replace all usage of .deliver to .deliver_now
  def deliver_now(*args)
    super
  end
end

RSpec.describe DailyDigestEmail, type: :labor do
  let(:user) { create(:user, email_daily_digest_notifications: true) }
  let(:author) { create(:user) }
  let(:mock_delegator) { instance_double("FakeDelegator") }

  before do
    allow(DailyDigestMailer).to receive(:daily_digest_email) { mock_delegator }
    allow(mock_delegator).to receive(:deliver_now).and_return(true)
    user
  end

  context "when daily digest email" do
    before { user.follow(author) }

    it "send email based on highest page view count, article being published in last 14 days, and hotness score" do
      article = create(:article, user_id: author.id, page_views_count: 50, published_at: 5.days.ago.utc, hotness_score: 25)
      article2 = create(:article, user_id: user.id, page_views_count: 30, published_at: 15.days.ago.utc, hotness_score: 15)
      article3 = create(:article, user_id: author.id, page_views_count: 40, published_at: 5.days.ago.utc, hotness_score: 25)

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
