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
      flash[:message] = "Please provide all fields."
      redirect "/signup"
    else
      if User.all.map {|u| u.username}.include?(params[:username])
        flash[:message] = "That username is taken! Try another!"
        redirect "/signup"
      elsif User.all.map {|u| u.email}.include?(params[:email])
        flash[:message] = "That email is already associated with an account."
        redirect "/login"
      else
        @user = User.create(params)
        session[:user_id] = @user.id
        flash[:message] = "Sign up successful! Welcome to I HAVE THAT!"
        redirect "/items"
      end
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
        flash[:message] = "Hmmm. Something went wrong. Try again!"
        redirect "/login"
      end
  end

  get '/user/:slug' do
    @session = session[:user_id]
    @user = User.all.find_by_slug(params[:slug])
    erb :'users/show'
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
