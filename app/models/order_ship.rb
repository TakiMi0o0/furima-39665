class OrderShip
  include ActiveModel::Model
  attr_accessor :token, :item_id, :user_id, :post_code, :prefecture_id, :city, :address, :building, :phone_number
  with_options presence: true do
    validates :token
    validates :post_code, 
      format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :item_id, :user_id, :city, :address
    validates :phone_number, 
      format: { with: /\A\d{10,11}\z/,message: "is invalid."}
  end
  validates :prefecture_id, 
    numericality: {other_than: 0, message: "can't be blank"}

  def save
    @order = Order.create(user_id: user_id)
    Ship.create(post_code: post_code, prefecture_id: prefecture_id, city: city, 
      address: address, building: building, phone_number: phone_number, order_id: @order.id)
  end

end