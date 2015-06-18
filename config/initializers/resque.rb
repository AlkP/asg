require 'resque_scheduler'

rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'production'

uri = URI.parse("redis://localhost:6379/")
#uri = URI.parse("redis://78.47.118.231:6379/")
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }
