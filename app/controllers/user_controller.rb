class UserController < ApplicationController

  get '/signup' do
    if logged_in?
        redirect "/items"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup'  do
    if params[:username]=="" || params[:email]==""|| params[:password]==""
      redirect "/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/items"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/items"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/items"
      else
        redirect "/login"
      end
  end

  get '/user/:id' do
    #can see all user items and links to item:id page
    #MAYBE can change username
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/"
    else
      redirect "/"
    end
  end


end
