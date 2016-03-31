namespace :db_refresher do
  desc 'Refresh current db state to all migrations (from cache if available)'
  task refresh: :environment do
    puts "Refresh!"
  end

  desc 'Refresh current cache'
  task refresh_cache: :environment do
    puts "Refresh with cache!"
  end
end

desc 'Run default refresh task'
task :db_refresher => ['db_refresher:refresh']
