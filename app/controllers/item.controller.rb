class ItemController < ApplicationController

  get '/items' do
    @items = Item.all
    erb :'/items/show'
  end

  get '/items/new' do
    erb :'/items/add_item'
  end

  post '/items/new' do
    @user = User.find(session[:user_id])
    @user.items << Item.create(params[:item])
    redirect "/items"
  end

  get '/items/:id' do

  end

end
