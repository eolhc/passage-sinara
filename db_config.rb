require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'passage'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
