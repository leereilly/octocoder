ENV["RACK_ENV"] ||= "development"

require 'bundler'
Bundler.setup

Bundler.require(:default, ENV["RACK_ENV"].to_sym)

Dir["./lib/**/*.rb"].each { |f| require f }

raise 'DATABASE_URL not set (see README)' unless ENV['DATABASE_URL']

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://my.db')
DataMapper.auto_upgrade!

