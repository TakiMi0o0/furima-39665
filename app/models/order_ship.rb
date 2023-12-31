class OrderShip
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building, :phone_number
  with_options presence: true do
    validates :token, :user_id, :item_id
    validates :post_code, 
      format: {with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, 
      numericality: {other_than: 0 }
    validates :city, :address
    validates :phone_number, 
      format: { with: /\A\d{10,11}\z/ }
  end

  def save
    @order = Order.create(user_id: user_id, item_id: item_id)
    Ship.create(order_id: @order.id, post_code: post_code, prefecture_id: prefecture_id, 
      city: city, address: address, building: building, phone_number: phone_number)
  end

end