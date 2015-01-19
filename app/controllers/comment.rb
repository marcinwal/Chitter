get '/commentnew/:id' do
  peep_ref = params[:id]
  # byebug
  @peep = Peep.first(:id => peep_ref)
  @comments = Comment.all(:peep_id => peep_ref)
  erb :"comment/viewcomments"
end

get '/newcomment/:id' do
 peep_id = params[:id]
 comment = params[:newcomment] 
 comm = Comment.create(:comment => comment,
                       :peep_id => peep_id,
                       :user_id => session[:user_id])
 @peep = Peep.first(:id => peep_id)
 @comments = Comment.all(:peep_id => @peep.id)
 #erb :"comment/viewcomments"
 redirect "/commentnew/#{peep_id}"
end