class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.all
    @title = '商品'
    @count = @items.count
    genre_params = params[:genre_id]
    # if params[:genre_id].present?
    if genre_params.present?
      @items = Item.where(genre_id: genre_params)
      @count = @items.count
      genre = Genre.find(genre_params)
      @title = genre.name
    end
  end

  # def re()
  #   @genres = Genre.all
  #   @text = 'a'
  #   render :index
  # end

  def show
  end

end
