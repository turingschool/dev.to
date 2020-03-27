class DailyDevMailer < ApplicationMailer
  default from: -> { "Daily Dev <#{SiteConfig.default_site_email}>" }

  def daily_dev_email(address, id, article)
    @article = article
    @unsubscribe = generate_unsubscribe_token(id, :email_daily_dev)
    subject = "Your Daily Dev"
    mail(to: address, subject: subject)
  end
end
