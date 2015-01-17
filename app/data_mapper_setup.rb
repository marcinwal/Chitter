env = ENV["RACK_ENV"] || 'development'

require './app/models/user'
require './app/models/peep'
require './app/models/comment'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
DataMapper.finalize
