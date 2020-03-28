class DailyDevEmail
  def self.send_daily_dev_email(users = [])
    new(users).send_daily_dev_email
  end

  def initialize(users = [])
    @users = users.empty? ? get_users : users
  end

  def send_daily_dev_email
    @users.find_each do |user|
      article = EmailLogic.new(user).analyze_daily_dev
      begin
        DailyDevMailer.daily_dev_email(user, article).deliver_now if user.email_daily_dev == true
      rescue StandardError => e
        Rails.logger.error("Email issue: #{e}")
      end
    end
  end

  private

  def get_users
    User.where(email_daily_dev: true).where.not(email: "")
  end
end
