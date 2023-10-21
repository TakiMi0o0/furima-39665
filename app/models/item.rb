class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :item_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_date
  has_one_attached :image

  validates :image, :user, :item_name, :price, :description, :category_id, :item_status_id, :shipping_fee_id, :prefecture_id, :shipping_date_id, presence: true
  validates :category_id, :item_status_id, :shipping_fee_id, :prefecture_id, :shipping_date_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :price, numericality:  { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 },
                    presence: { other_than: 1 , message: "can't be blank" },
                    format: { with: /\A[0-9]+\z/, message: 'は半角数字で入力して下さい' }

end
