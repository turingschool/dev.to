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

    expect(page).to have_text("Your profile was successfully updated.")

    expect(user.email_daily_digest_notifications).to be(true)
  end
end
