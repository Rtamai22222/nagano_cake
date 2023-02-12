class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @title = '商品'
    @items = Item.all
    @count = @items.count
    genre_params = params[:genre_id]
    if genre_params.present?
      genre = Genre.find(genre_params)
      @title = genre.name
      @items = Item.where(genre_id: genre_params)
      @count = @items.count
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart = CartItem.new
  end

end
