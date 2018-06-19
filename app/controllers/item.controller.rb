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
    @item = Item.all.find(params[:id])
      if logged_in?
        erb :'items/show_one'
      else
        redirect "/login"
      end
    #can see item page
    #can contact item user?
  end

  get 'items/:id/edit' do
    #if logged in and item belongs to you
    #can edit an item Name
    #can edit item description
    #return to user item list
  end

  patch 'items/:id' do

  end

  post 'items/:id/delete' do
    #deletes item
  end


end
