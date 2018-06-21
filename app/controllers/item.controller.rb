class ItemController < ApplicationController

  get '/items' do
    @user = current_user
    @items = Item.all
    erb :'/items/show'
  end

  get '/items/new' do
    erb :'/items/add_item'
  end

  post '/items/new' do
    @user =  current_user
    if params[:item][:name] != "" && params[:item][:detail] != ""
      # @user.items << Item.create(params[:item])
      @user.items.build(name: params[:item][:name], detail: params[:item][:detail])
      @user.save
      flash[:message] = "Success! Thank you for adding an item for community lending."
      redirect "/items"
    else
      flash[:message] = "You must fill all fields"
      redirect "/items/new"
    end
  end

  get '/items/:id' do
    @item = Item.all.find(params[:id])
      if logged_in? && current_user.id == @item.user_id
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
      if @item && current_user.id == @item.user_id
      erb :'items/edit_item'
      else
        flash[:message] = "You can't edit someone else's item!"
        redirect "/items"
      end
    else
      redirect "/login"
    end
  end

  patch '/items/:id' do
    if logged_in?
        @item = Item.all.find(params[:id])
        if current_user.id == @item.user_id
          if params[:item][:name] != "" && params[:item][:detail] != ""
          @item.update(params[:item])
          elsif params[:item][:name] != ""
            @item.update(name: params[:item][:name])
          else
            @item.update(detail: params[:item][:detail])
          end
          flash[:message] = "Successfully updated item."
          redirect "/user/#{@item.user.slug}"
        else
          flash[:message] = "Something went wrong. Try again!"
          redirect "/items/#{@item.id}/edit"
        end
      else
        flash[:message] = "You must be logged in."
        redirect "/login"
    end
  end

  post '/items/:id/delete' do
    @item = Item.all.find(params[:id])
    if logged_in? && current_user.id == @item.user_id
      @item.delete
      flash[:message] = "You have deleted your item."
      redirect "/items"
    else
      redirect "/items"
    end
  end

end
