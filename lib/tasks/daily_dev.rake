desc 'sends daily dev emails'
task daily_dev: :environment do
  User.daily_dev_email
end
