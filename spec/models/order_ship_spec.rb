require 'rails_helper'

RSpec.describe OrderShip, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:user)
      @order_ship = FactoryBot.build(:order_ship, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_ship).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_ship.building = ''
        expect(@order_ship).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'userが紐付いていなければ出品できない' do
        @order_ship.user_id = nil
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていなければ出品できない' do
        @order_ship.item_id = nil
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Item can't be blank")
      end
      it "tokenが空では登録できないこと" do
        @order_ship.token = nil
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Token can't be blank")
      end
      it 'post_codeが空だと保存できないこと' do
        @order_ship.post_code = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_ship.post_code = '1234567'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @order_ship.prefecture_id = nil
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefectureに「---」が選択されている場合は保存できないこと' do
        @order_ship.prefecture_id = '0'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Prefecture must be other than 0")
      end
      it 'cityが空だと保存できないこと' do
        @order_ship.city = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @order_ship.address = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_ship.phone_number = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberは9桁以下では保存できないこと' do
        @order_ship.phone_number = '123456789'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include('Phone number is invalid.')
      end
      it 'phone_numberは12桁以上では保存できないこと' do
        @order_ship.phone_number = '123456789012'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include('Phone number is invalid.')
      end
      it 'phone_numberが全角数字では保存できないこと' do
        @order_ship.phone_number = '５００'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Phone number is invalid.")
      end
      it 'phone_numberが半角英字では保存できないこと' do
        @order_ship.phone_number = 'abcdefghijk'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Phone number is invalid.")
      end
    end
  end
end