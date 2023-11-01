FactoryBot.define do
  factory :order_ship do
    token         {"tok_abcdefghijk00000000000000000"}
    post_code     { '123-4567' }
    prefecture_id { 1 }
    city          { 'もじゃ市' }
    address       { '1-1' }
    building      { 'ハイツ' }
    phone_number  { rand(1000000000..99999999999) }
  end
end
