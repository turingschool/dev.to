module Notifications
  class DailyDevWorker
    include Sidekiq::Worker

    sidekiq_options queue: :medium_priority, retry: 10

    def perform(users, articles)
      users.each do |user|
        article = articles.sample
        DailyDevMailer.send_email(user, article)
      end
    end
  end
end
