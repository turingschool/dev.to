set :output, "#{path}/log/cron.log"

every 7.days do
  runner "UpdateMachineCollections"
end
