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
        expect(@item.errors.full_messages).to include("ユーザーを入力してください")
      end
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it 'item_nameが空では保存できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'descriptionが空では保存できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'categoryが空では保存できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it 'categoryに「---」が選択されている場合は出品できない' do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーは0以外の値にしてください")
      end
      it 'item_statusが空では保存できない' do
        @item.item_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it 'item_statusに「---」が選択されている場合は出品できない' do
        @item.item_status_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態は0以外の値にしてください")
      end
      it 'shipping_feeが空では保存できない' do
        @item.shipping_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it 'shipping_feeに「---」が選択されている場合は出品できない' do
        @item.shipping_fee_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担は0以外の値にしてください")
      end
      it 'prefectureが空では保存できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it 'prefectureに「---」が選択されている場合は出品できない' do
        @item.prefecture_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域は0以外の値にしてください")
      end
      it 'shipping_dateが空では保存できない' do
        @item.shipping_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end
      it 'shipping_dateに「---」が選択されている場合は出品できない' do
        @item.shipping_date_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数は0以外の値にしてください")
      end
      it 'priceが空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it 'priceが299円以下では保存できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は300以上の値にしてください")
      end
      it 'priceが10,000,000円以上では保存できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は9999999以下の値にしてください")
      end
      it 'priceが全角数字では保存できない' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
    end
  end
end

