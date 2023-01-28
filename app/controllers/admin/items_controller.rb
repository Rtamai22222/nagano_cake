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
  end

  def edit
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end
