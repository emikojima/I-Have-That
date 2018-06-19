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
      if logged_in? && session[:user_id] == @item.user_id
        redirect "/items/#{@item.id}/edit"
      elsif logged_in?
        erb :'items/show_one'
      else
        redirect "/login"
      end
  end

  get '/items/:id/edit' do
    if logged_in?
        @item = Item.all.find(params[:id])
        if @item && session[:user_id] == @item.user_id
        erb :'items/edit_item'
        else
          redirect "/items"
        end
    else
      redirect "/login"
    end

    #if logged in and item belongs to you
    #can edit an item Name
    #can edit item description
    #return to user item list
  end

  post '/items/:id' do
    if logged_in?
        @item = Item.all.find(params[:id])
        if session[:user_id] == @item.user_id
          if params[:item][:name] != "" && params[:item][:detail] != ""
          @item.update(params[:item])
          flash[:message] = "Successfully updated."
          elsif params[:item][:name] != ""
            @item.update(name: params[:item][:name])
          else
            @item.update(detail: params[:item][:detail])
          end
            redirect "/user/#{@item.user.slug}"
        else
          redirect "/items/#{@item.id}/edit"
        end
      else
        redirect "/login"
    end
  end

  post '/items/:id/delete' do
    @item = Item.all.find(params[:id])
    if logged_in? && session[:user_id] == @item.user_id
      @item.delete
      redirect "/items"
    else
      redirect "/items"
    end
  end

end
