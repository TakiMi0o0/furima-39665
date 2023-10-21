class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index]

  def index
    @items = Item.find
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
    redirect_to '/'
  end


  private
  def item_params
    params.require(:item).permit(:image, :user, :item_name, :price, :description, :category_id, :item_status_id, :shipping_fee_id, :prefecture_id, :shipping_date_id).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
  
end
