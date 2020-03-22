# mailers are what is sent out as an email to a user - literally a mailer
# mailers are objects
# this mailer is for a users article choice - sends the first six
# it generates a generic title by pulling article first title, size of article length, an end phrase and the emojis
# it adds on three random emojis to the email from the array on line 33
# end phrase comes from a list of phrases in an array on line 37

class DigestMailer < ApplicationMailer
  # where the email gets sent from
  # default_site_email is an email string
  default from: -> { "DEV Digest <#{SiteConfig.default_site_email}>" }

  def digest_email(user, articles)
    @user = user
    @articles = articles.first(6)
    @unsubscribe = generate_unsubscribe_token(@user.id, :email_digest_periodic)
    subject = generate_title
    mail(to: @user.email, subject: subject)
  end

  private

  def generate_title
    # similar to 'this.' these variables reference the methods in this object
    "#{adjusted_title(@articles.first)} + #{@articles.size - 1} #{email_end_phrase} #{random_emoji}"
  end

  def adjusted_title(article)
    title = article.title.strip
    # condition that adds quotes to the title unless there is already quotations
    "\"#{title}\"" unless title.start_with? '"'
  end

  def random_emoji
    ["🤓", "🎉", "🙈", "🔥", "💬", "👋", "👏", "🐶", "🦁", "🐙", "🦄", "❤️", "😇"].shuffle.take(3).join
  end

  def email_end_phrase
    # "more trending DEV posts" won the previous split test
    # Included more often as per explore-exploit algorithm
    [
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "other posts you might like",
      "other DEV posts you might like",
      "other trending DEV posts",
      "other top DEV posts",
      "more top DEV posts",
      "more top reads from the community",
      "more top DEV posts based on your interests",
      "more trending DEV posts picked for you",
    ].sample
  end
end
