require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "?"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    if Helpers.is_logged_in?(session)
      redirect to '/tickets'
    else
      erb :welcome
    end 
  end
end
