require 'rails_helper'

RSpec.describe OrderShip, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_ship = FactoryBot.build(:order_ship, user_id: user.id, item_id: item.id)
      sleep(1)
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
        expect(@order_ship.errors.full_messages).to include("ユーザーを入力してください")
      end
      it 'itemが紐付いていなければ出品できない' do
        @order_ship.item_id = nil
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("アイテムを入力してください")
      end
      it "tokenが空では登録できないこと" do
        @order_ship.token = nil
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'post_codeが空だと保存できないこと' do
        @order_ship.post_code = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_ship.post_code = '1234567'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @order_ship.prefecture_id = nil
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'prefectureに「---」が選択されている場合は保存できないこと' do
        @order_ship.prefecture_id = '0'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("都道府県は0以外の値にしてください")
      end
      it 'cityが空だと保存できないこと' do
        @order_ship.city = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'addressが空だと保存できないこと' do
        @order_ship.address = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_ship.phone_number = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberは9桁以下では保存できないこと' do
        @order_ship.phone_number = '123456789'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberは12桁以上では保存できないこと' do
        @order_ship.phone_number = '123456789012'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが全角数字では保存できないこと' do
        @order_ship.phone_number = '５００'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが半角英字では保存できないこと' do
        @order_ship.phone_number = 'abcdefghijk'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("電話番号は不正な値です")
      end
    end
  end
end