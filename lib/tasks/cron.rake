require 'games/wordico/flow'

desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  game_flow = Games::Wordico::Flow.new
  game_flow.hourly
end