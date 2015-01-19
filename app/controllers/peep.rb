get '/newpeep' do
  erb :"peep/newpeep"
end

post '/newpeep' do 
  newpeep = params[:newpeep]
  peep = Peep.create(:text => newpeep, :user_id => session[:user_id]) #!!!
  flash[:notice] = "Thank you for your new peep!"
  redirect '/'
end