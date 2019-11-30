require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
  end
  
  get "/" do
    
		erb :index
	end
	
	get "/signup" do
	 if Helpers.is_logged_in?(session)
	  redirect '/tweets'
	 else
	   
	  erb :signup
	 end
  end
	
	post "/signup" do
	 
	  if params[:username] == "" || params[:password] == "" || params[:email] == ""
	    redirect '/signup'
	  else
	    user = User.create(params)
	    session[:user_id] = user.id
	    redirect '/tweets'
	  end
  end
  
  get '/login' do
    if Helpers.is_logged_in?(session)
  	  redirect '/tweets'
	  else 
	   
	    erb :login
	  end
  end
  
  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
     
      redirect to "/tweets"
    end 
      redirect '/login'
  end
  
  get '/logout' do 
    if Helpers.is_logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
  

end
