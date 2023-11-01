require 'rails_helper'

RSpec.describe OrderShip, type: :model do
  describe '購入情報の保存' do
    before do
      @order_ship = FactoryBot.build(:order_ship)
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
      it 'phone_numberは10桁以上11桁以内の半角数値のみ保存可能なこと' do
        @order_ship.phone_number = '123456789012'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include('Phone number is invalid.')
      end
    end
  end
end