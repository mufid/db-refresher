namespace :db_refresher do
  desc 'Refresh current db state to all migrations (from cache if available)'
  task refresh: :environment do

    conn = nil
    safe_schema_head_sql = nil
    use_safe = false

    begin
      conn = ActiveRecord::Base.connection
      safe_schema_head_sql = "drop schema public cascade; create schema public;"
      use_safe = true
      sql = ActiveRecord::Base.send(:sanitize_sql_array, safe_schema_head_sql)
      conn.execute(sql)
    rescue ActiveRecord::NoDatabaseError, PG::ConnectionBad => e
      puts "Woops: #{e.message}"

      safe_schema_head_sql = File.read(File.join(File.dirname(__FILE__), '..', 'sql', 'postgres_head.sql'))      

      config = Rails.configuration.database_configuration[Rails.env]

      variables = {
        db_name:  config['database'],
        user_name: config['username'],
      }

      variables.each_pair do |key, value|
        safe_schema_head_sql = safe_schema_head_sql.gsub("s{#{key}}", value)
      end

      file_name = "/tmp/refresh_db-#{Time.now.to_i}.sql"

      File.write(file_name, safe_schema_head_sql)

      system("sudo -u postgres psql < #{file_name}")
    end
    

  end

  desc 'Refresh current cache'
  task refresh_cache: :environment do
    puts "Refresh with cache!"
  end
end

desc 'Run default refresh task'
task :db_refresher => ['db_refresher:refresh']
