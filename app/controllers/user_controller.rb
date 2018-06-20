class UserController < ApplicationController

  get '/signup' do
    if logged_in?
        redirect "/items"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup'  do
      if User.all.map {|u| u.username}.include?(params[:username])
        flash[:message] = "That username is taken! Try another!"
        redirect "/signup"
      elsif User.all.map {|u| u.email}.include?(params[:email])
        flash[:message] = "That email is already associated with an account."
        redirect "/"
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

  get '/user' do
    @users = User.all
      erb :'/users/show_all'
  end

  get '/user/:slug' do
    @session = session[:user_id]
    @user = User.all.find_by_slug(params[:slug])
    erb :'/users/show'
    #MAYBE can change username
  end

  get '/user/:slug/edit' do
    @user = User.all.find_by_slug(params[:slug])
    if logged_in? && session[:user_id] = @user.id
      erb :'/users/edit'
    else
      redirect  "/user/#{@user.slug}"
    end
  end

  patch '/user/:slug' do
    @user = User.all.find_by_slug(params[:slug])
    if params[:username] != "" && !User.all.map {|u| u.username}.include?(params[:username])
       @user.update(username: params[:username])
       flash[:message] = "You have successfully updated your username!"
       redirect "/user/#{@user.slug}"
     else
       flash[:message] = "Hmmm. That username is taken. Try again!"
       redirect "/user/#{@user.slug}/edit"
     end

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
