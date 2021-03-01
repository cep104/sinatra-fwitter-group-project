class TweetsController < ApplicationController

get '/tweets' do
   # binding.pry
    if !logged_in?
        redirect to :"/login"
    else
        @tweets = Tweet.all
        @user = User.find_by(id: session[:user_id])
        erb :"tweets/tweets"
    end
end

get '/tweets/new' do
    if logged_in?
        erb :"tweets/new"
    else
        redirect to :"/login"
    end
end

post '/tweets' do
    if !params[:content].empty?
    @tweet = Tweet.create(params)
    @tweet.user = current_user
    @tweet.save
        redirect to :"/tweets/#{@tweet.id}"
    else
        redirect to :"/tweets/new"
    end
end

get '/tweets/:id/edit' do
    if logged_in?
        @tweet = Tweet.find_by(id: params[:id])
        if @tweet && @tweet.user == current_user
            erb :"tweets/edit"
        else
            redirect to :"/tweets"
        end
    else
        redirect to :"/login"
    end
end

patch '/tweets/:id' do
    if logged_in?
        if params[:content] == ""
            redirect to :"/tweets/#{params[:id]}/edit"
        else
            @tweet = Tweet.find_by_id(params[:id])
                if @tweet && @tweet.user == current_user
                   if @tweet.update(content: params[:content])
                    redirect to :"/tweets/#{@tweet.id}"
                   else
                    redirect to :"/tweets/#{@tweet.id}/edit"
                   end
                else
                    redirect to :"/tweets"
                end
        end
    else
        redirect to :"/login"
    end  
end

get '/tweets/:id' do
    if logged_in?
        @tweet = Tweet.find_by(id: params[:id])
        erb :"tweets/show"
    else
        redirect to :"/login"
    end
end

post '/tweets/:id/delete' do
    if logged_in?
    @tweet = Tweet.find_by(id: params[:id])
        if @tweet && @tweet.user == current_user
        @tweet.delete
        end
        redirect to :"/tweets"
    else
        redirect to :"/login"
    end
end

end
