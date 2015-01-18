require 'sinatra'
require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require 'mailgun'

require 'byebug'

require_relative 'data_mapper_setup'

set :partial_template_engine, :erb
set :public, 'public'

env = ENV["RACK_ENV"] || 'development'

enable :sessions
set :sessions_secret, 'super secret' 
use Rack::Flash  #using flash
use Rack::MethodOverride


get '/' do
  #session.clear #to delete !!! 
  @peeps = Peep.all
  erb :index
end

get '/newuser' do 
  @user = User.new
  erb :"user/newuser"
end

post '/newuser' do 
  @user = User.create(:name => params[:name], :username => params[:username],
                     :password => params[:password], :password_confirmation => params[:password_confirmation])
  if @user.save 
    session[:user_id] = @user.id
    redirect '/'#erb :index
  else
    flash.now[:errors] = @user.errors.full_messages
    redirect '/'#erb :index
  end
end

 
get '/signin' do #user is logging in 
  erb :"user/signin"
end

post '/signin' do
  email_or_username,password = params[:email_or_username],params[:password]
  user = User.authenticate_email(email_or_username,password)
  user = User.authenticate_username(email_or_username,password) if !user
  if !user
      flash[:errors] = ["Wrong email, username or password"]
      redirect '/'
  else 
      session[:user_id] = User.first(:email => user.email).id
      flash[:notice] = "Welcome back #{user.username}"
      redirect '/'
  end    
end 

delete '/signout' do 
   flash[:notice] = "Good bye! #{current_user.username}"
   session[:user_id] = nil
   redirect '/'
end  

get '/newpeep' do
  erb :"peep/newpeep"
end

post '/newpeep' do 
  newpeep = params[:newpeep]
  peep = Peep.create(:text => newpeep, :user_id => current_user.id)
  flash[:notice] = "Thank you for your new peep!"
  redirect '/'
end

