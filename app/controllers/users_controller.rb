# require './config/environment'

class UsersController < ApplicationController

    get '/signup' do
        if Helpers.is_logged_in?(session)
            redirect to '/show' 
        else
            erb :'/users/signup'
        end 
    end

    post '/signup' do
        if !params[:username].empty? && !params[:password].empty?
            user = User.new
            user.username = params[:username]
            user.password = params[:password] 
            user.save
            session[:user_id] = user.id
            redirect to '/show' 
        else
            redirect to 'signup'
        end 
    end
end