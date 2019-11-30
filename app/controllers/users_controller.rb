class UsersController < ApplicationController

   get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if !@user.nil?
      erb :'/users/user_tweets'
    else 
      redirect to '/login'
    end
  end 
 

end
