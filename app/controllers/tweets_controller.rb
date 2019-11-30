class TweetsController < ApplicationController
  
  get '/tweets' do 
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweets = Tweet.all 
      erb :'/tweets/tweets'
    else 
      redirect '/login'
    end
  end
  
  get '/tweets/new' do 
    if Helpers.is_logged_in?(session)
      
    erb :'/tweets/new'
    else 
      redirect '/login'
    end
  end 
  
  post '/tweets' do 
   user = Helpers.current_user(session)
    if params[:content].empty?
     redirect '/tweets/new'
    elsif
     tweet = Tweet.create(:content => params[:content], :user_id => user.id)
     redirect '/tweets'
    else 
     redirect '/login'
   end
  end
  
  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show_tweet'
    else 
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do 
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(:id => params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end 
  
  patch '/tweets/:id' do
    @user = Helpers.current_user(session)
    @tweet = Tweet.find_by(params[:id])
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    elsif 
      params[:content] == ""
        redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(:content => params[:content],:user_id => @user.id)
      redirect '/tweets'
    # lets a user edit their own tweet if they are logged in 
    end
    # does not let a user edit a text with blank content
  end
  
  delete '/tweets/:id/delete' do 
    @user = Helpers.is_logged_in?(session)
    @tweet = Tweet.find_by(params[:id])
    if @user && @tweet.id = params[:id]
      @tweet.destroy 
    end
  end

end
