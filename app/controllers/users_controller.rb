# require './config/environment'

class UsersController < ApplicationController

    get '/signup' do
        if Helpers.is_logged_in?(session)
            redirect to '/tickets' 
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
            redirect to '/tickets' 
        else
            redirect to 'signup'
        end 
    end

    get '/login' do
        if !Helpers.is_logged_in?(session)
            erb :'/users/login'
        else
            redirect to '/tickets'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
        end
        redirect to '/tickets' 
    end

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
        end
        redirect to '/login'
    end

    post '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
        end
        redirect to '/login'
    end 
end