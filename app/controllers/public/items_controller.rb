class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @title = '商品'
    # @items = Item.all
    @items = Item.page(params[:page])
    @count = @items.count
    genre_params = params[:genre_id]
    if genre_params.present?
      genre = Genre.find(genre_params)
      @title = genre.name
      items = Item.where(genre_id: genre_params)
      @items = items.page(params[:page])
      @count = @items.count
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart = CartItem.new
  end

end
