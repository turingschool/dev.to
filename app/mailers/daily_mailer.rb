class DailyMailer < ApplicationMailer
  default from: -> { "DEV Daily <#{SiteConfig.default_site_email}>" }

  def daily_email(user, article)
    @user = user
    @article = article.first
    @unsubscribe = generate_unsubscribe_token(@user.id, :email_daily_dev)
    subject = generate_title
    mail(to: @user.email, subject: subject)
  end

  private

  def generate_title
    adjusted_title(@article).to_s
  end

  def adjusted_title(article)
    title = article.title.strip
    "\"#{title}\"" unless title.start_with? '"'
  end
end
