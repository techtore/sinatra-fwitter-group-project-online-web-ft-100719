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
	 
	  if params[:username] == "" || params[:password] == "" || params[:email]
	    redirect '/signup'
	  else
	    user = User.create(params)
	    session[:user_id] = user.id
	    redirect '/tweets'
	  end
  end

end
