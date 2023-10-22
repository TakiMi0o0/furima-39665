require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品機能' do
    context '出品できる場合' do
      it 'すべての項目が正しく入力されていれば保存できる' do
        expect(@item).to be_valid
      end
    end
    context '出品できない場合' do
      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_nameが空では保存できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'descriptionが空では保存できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'categoryが空では保存できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'categoryに「---」が選択されている場合は出品できない' do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end
      it 'item_statusが空では保存できない' do
        @item.item_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status can't be blank")
      end
      it 'item_statusに「---」が選択されている場合は出品できない' do
        @item.item_status_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status must be other than 0")
      end
      it 'shipping_feeが空では保存できない' do
        @item.shipping_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end
      it 'shipping_feeに「---」が選択されている場合は出品できない' do
        @item.shipping_fee_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee must be other than 0")
      end
      it 'prefectureが空では保存できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefectureに「---」が選択されている場合は出品できない' do
        @item.prefecture_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 0")
      end
      it 'shipping_dateが空では保存できない' do
        @item.shipping_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank")
      end
      it 'shipping_dateに「---」が選択されている場合は出品できない' do
        @item.shipping_date_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date must be other than 0")
      end
      it 'priceが空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが299円以下では保存できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが10,000,000円以上では保存できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'priceが全角数字では保存できない' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end

