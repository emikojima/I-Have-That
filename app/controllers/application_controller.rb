require './config/environment'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    enable :sessions
    set :session_secret, "password_security"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

  def logged_in?
    !!session[:user_id]
  end

end
