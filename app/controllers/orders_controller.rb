class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
    @order_ship = OrderShip.new
  end

  def create
    @order_ship = OrderShip.new(order_params)
    if @order_ship.valid?
      @order_ship.save
      return redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_ship).permit(:post_code, :prefecture_id, :city, :address, :building, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id)
  end

end
