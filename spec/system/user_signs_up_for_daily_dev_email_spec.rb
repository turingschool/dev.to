require "rails_helper"

RSpec.describe "Opts in to Daily Dev Email", type: :system do
  let(:user) { create(:user, saw_onboarding: true) }

  before do
    sign_in(user)
    visit "/settings/notifications"
  end

  it "lets user sign up for daily dev email" do
    expect(user.email_daily_digest_notifications).to be(false)

    expect(page).to have_unchecked_field("Send me my daily dev email")
    page.check "Send me my daily dev email"

    click_on "SUBMIT"
    user.reload

    expect(page).to have_text("Your profile was successfully updated.")
    expect(page).to have_checked_field("Send me my daily dev email")

    expect(user.email_daily_digest_notifications).to be(true)
  end

  it "lets user change daily email setting" do
    expect(user.email_daily_digest_notifications).to be(false)
    page.check "Send me my daily dev email"

    click_on "SUBMIT"
    user.reload

    expect(user.email_daily_digest_notifications).to be(true)

    page.uncheck "Send me my daily dev email"

    click_on "SUBMIT"
    user.reload

    expect(user.email_daily_digest_notifications).to be(false)
  end

  it "has unchecked email notification setting checkboxes" do
    expect(page).to have_unchecked_field("Send me my daily dev email")
    expect(page).to have_unchecked_field("Send me a periodic digest of top posts from my tags")
  end

  it "has checked email notification setting checkboxes" do
    expect(page).to have_checked_field("Send me weekly newsletter emails")
    expect(page).to have_checked_field("Send me an email when someone replies to me in a comment thread")
    expect(page).to have_checked_field("Send me an email when someone new follows me")
    expect(page).to have_checked_field("Send me an email when someone mentions me")
    expect(page).to have_checked_field("Send me an email when I receive a badge")
    expect(page).to have_checked_field("Send me an email when I receive a direct message (while inactive)")
    expect(page).to have_checked_field("Send me occasional reminders that I have unread notifications on dev.to")
  end
end
