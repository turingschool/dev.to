# Usecase would be
# EmailDigest.send_periodic_digest_email
# OR
# EmailDigets.send_periodic_digest_email(Users.first(4))

class EmailDigest
  def self.send_periodic_digest_email(users = [])
    new(users).send_periodic_digest_email
  end

  def initialize(users = [])
    @users = users.empty? ? get_users : users
  end

  # This method looks like something we could use in the future
  # Line 24 & 25: finds user in database of users
  # EmailLogic class has method called analyze
  # The next statement is used to skip a part of the loop and continue
  # with the next iteration of the loop. It can be used in combination with
  # for and while statements. In this case looks at 'should_receive_email?'
  # Line 28 - 29 > method: should_receive_email is defined as @ready_to_recieve_email
  # which then gets called inside get_articles_to_send <= looks like
  # has some sort of logic in there about the users followed articles.
  # Begin class DigestMailer
  def send_periodic_digest_email
    @users.find_each do |user|
      user_email_heuristic = EmailLogic.new(user).analyze
      next unless user_email_heuristic.should_receive_email?

      articles = user_email_heuristic.articles_to_send
      begin
        DigestMailer.digest_email(user, articles).deliver if user.email_digest_periodic == true
      rescue StandardError => e
        Rails.logger.error("Email issue: #{e}")
      end
    end
  end

  private

  def get_users
    User.where(email_digest_periodic: true).where.not(email: "")
  end
  # Do a query to check all users to check daily dev email is marked as true
end
