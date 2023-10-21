class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :user
  has_one_attached :image

  validates :user, :item_name, :price, :description, :category_id, :item_status_id, :shipping_fee_id, :prefecture_id, :shipping_date_id, presence: true
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}

end
