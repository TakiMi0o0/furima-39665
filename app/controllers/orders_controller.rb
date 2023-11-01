class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_top
  before_action :set_item, only: [:index, :create]

  def index
    @order_ship = OrderShip.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @order_ship = OrderShip.new(order_params)
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if @order_ship.valid?
      pay_item
      @order_ship.save
      return redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_ship)
    .permit(:post_code, :prefecture_id, :city, :address, :building, :phone_number)
    .merge(token: params[:token], item_id: params[:item_id], user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_top
    @item = Item.find(params[:item_id])
    if @item.order.present? || current_user.id == @item.user_id
      redirect_to root_path
    end
  end

end
