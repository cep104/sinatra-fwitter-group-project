class UsersController < ApplicationController

get '/' do
    erb :"/users/home"
end

get '/signup' do
    if logged_in?
        redirect :"/tweets/index"
    end
    erb :"/users/signup"
end

post '/signup' do
    user = User.new(params)
    
    if !user.username.empty? && !user.email.empty? && user.save
        session[:user_id] = user.id
        redirect :"/tweets"
    else
        redirect :"/signup"
    end
    puts params
end

get '/login' do
    if !logged_in?
        erb :"users/login"
    else
        redirect :"/tweets"
    end
end

post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        #binding.pry
        redirect to :"/tweets"
    else
        redirect :"/signup"
    end
end

get '/logout' do
    if logged_in?
    session.clear
    redirect to :"/login"
    else
        redirect to :"/"
    end
end

get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @tweets = @user.tweets
        erb :"/users/show"
end

end
