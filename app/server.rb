require 'sinatra'
require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require 'mailgun'

require_relative 'data_mapper_setup'

set :partial_template_engine, :erb
set :public, 'public'

env = ENV["RACK_ENV"] || 'development'

enable :sessions
set :sessions_secret, 'super secret' 
use Rack::Flash  #using flash
use Rack::MethodOverride


get '/' do
  "Hello Chitter!"
  @peeps = Peep.all
  erb :index
end

get '/user/new' do 
  @user = User.new
  erb :"user/newuser"
end

post '/user' do 
end