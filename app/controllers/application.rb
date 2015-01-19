get '/' do
  #session.clear #to delete !!! 
  @peeps = Peep.all
  erb :index
end