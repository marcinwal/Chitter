require 'sinatra'
require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require 'mailgun'

require 'byebug'

require_relative 'data_mapper_setup'
require_relative 'helpers/application'
require_relative 'controllers/application'
require_relative 'controllers/user'
require_relative 'controllers/peep'
require_relative 'controllers/comment'
require_relative 'controllers/password'


set :partial_template_engine, :erb
set :public, 'public'
HELP_PATH = "http://localhost:9292"

env = ENV["RACK_ENV"] || 'development'

enable :sessions
set :sessions_secret, 'super secret' 
use Rack::Flash  #using flash
use Rack::MethodOverride



get '/passwordrequest' do 
  erb :"password/passwordrequest"
end

post '/passwordrequest' do 
  email = params[:email]
  user = User.first(:email => email)
  if user
    token = (1..64).map{('A'..'Z').to_a.sample}.join
    user.password_token_timestamp = Time.now
    user.save
    msg = HELP_PATH # ?????? how to change it
    msg += "/passwordre?token=#{token}"
    puts msg
    send_simple_message("Chitter@chitter.com",email,"Recovery",msg)
    flash[:notice] = "Token has been sent to you!"
  else
    flash[:notice] = "No such user recorded"
  end  
  redirect to('/')  
end 

get '/passwordre' do 
  token = params[:token]
  user = User.first(:password_token => token)
  old_time =user.password_token_timestamp
  now = DateTime.now
  # byebug   ?????????????????????????
  if (user  && (now-old_time) < 900)
    user.update(:password_token => nil,:password_token_timestamp => nil)
    user.save
    redirect to :"password/recoveryinput"
  else
    flash[:errors] = "Wrong token or too late"
  end
end


post '/recoverypass' do 
  
end




