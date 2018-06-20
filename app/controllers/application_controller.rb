require './config/environment'
require 'sinatra/flash'
class ApplicationController < Sinatra::Base
  register Sinatra::Flash
  configure do
    enable :sessions
    set :session_secret, "password_security"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    if logged_in?
      redirect "/items"
    else
    erb :welcome
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
