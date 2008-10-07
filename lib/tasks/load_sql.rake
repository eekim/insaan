def load_sql_file(file)
  config = ActiveRecord::Base.configurations[RAILS_ENV]
  database = config['database']
  user = config['username']
  puts `mysql -u #{user} #{database} < #{file}`
end

desc 'Load an SQL file'
task :load_sql => [ENV['FILE'], :environment] do |t|
  file = ENV['FILE']
  file = RAILS_ROOT + "/" + file unless file[0].chr == '/'
  load_sql_file file
end

