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
      @user = User.create(params)
      session[:user_id] = @user.id
      flash[:message] = "Sign up successful! Welcome to I HAVE THAT!"
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
        flash[:message] = "Hmmm. Something went wrong. Try again!"
        redirect "/login"
      end
  end

  get '/user/:slug' do
    @user = User.all.find_by_slug(params[:slug])
    erb :'users/show'
    #can see all items and links to item:id page
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
