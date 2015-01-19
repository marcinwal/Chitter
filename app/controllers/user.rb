get '/newuser' do 
  @user = User.new
  erb :"user/newuser"
end

post '/newuser' do 
  @user = User.create(:name => params[:name], :username => params[:username],:email => params[:email],
                     :password => params[:password], :password_confirmation => params[:password_confirmation])
  if @user.save 
    session[:user_id] = @user.id
    redirect '/'#erb :index
  else
    flash[:errors] = @user.errors.full_messages
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
      session[:user_id] = user.id
      flash[:notice] = "Welcome back #{user.username.capitalize}"
      redirect '/'
  end   
end 

delete '/signout' do 
   flash[:notice] = "Good bye! #{current_user.username.capitalize}"
   session[:user_id] = nil
   redirect '/'
end  