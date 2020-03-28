# module Notifications
#   class DailyDevWorker
#     include Sidekiq::Worker
#
#     sidekiq_options queue: :medium_priority, retry: 10
#
#     def perform(email, id, article)
#       DailyDevMailer.daily_dev_email(email, id, article).deliver_now
#     end
#   end
# end
