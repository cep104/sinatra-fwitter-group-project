require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
      !!current_user #returns true if current user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      #if there is a session[:user_id] set current user to the the user_id of the session
      # x ||= y this means x || x = y
      # so if current_user is nil or false set current_user to be the value of y.
    end
  end
  
end
