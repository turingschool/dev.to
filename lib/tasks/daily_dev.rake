desc 'sends daily dev emails'
tast daily_dev: :environment do
  User.daily_dev_email
end
