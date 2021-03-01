require './config/environment'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secreet, "secret"
  end

  helpers do
    def current_user 
      # User.find_by(id: session[:user_id])
      current_user ||= User.find_by(id: session[:user_id]) if !!session[:user_id]
    end

    def logged_in?
      !!current_user
    end
  end

end
