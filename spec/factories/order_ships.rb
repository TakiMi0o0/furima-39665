FactoryBot.define do
  factory :order_ship do
    item_id       { 1 }
    user_id       { 1 }
    token         {"tok_abcdefghijk00000000000000000"}
    post_code     { '123-4567' }
    prefecture_id { 1 }
    city          { 'もじゃ市' }
    address       { '1-1' }
    building      { 'ハイツ' }
    phone_number  { '0123456789' }
  end
end
