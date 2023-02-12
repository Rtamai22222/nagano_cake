class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    # @item = Item.find(params[:id])
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # flash[:notice] = "You have created book successfully."
      redirect_to admin_items_path
    else
      @genres = Genre.all
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    genre = Genre.find(@item.genre_id)
    @genre = genre.name
    item_price = @item.price*1.1
    @include_tax = item_price.floor
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
     @item = Item.find(params[:id])
    if @item.update(item_params)
      # flash[:notice] = "You have updated book successfully."
      redirect_to admin_items_path
    else
      @genres = Genre.all
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end
